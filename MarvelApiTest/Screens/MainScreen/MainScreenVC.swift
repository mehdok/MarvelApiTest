//
//  MainScreenVC.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class MainScreenVC: BaseViewController<MainScreenVM> {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadIndicator: UIActivityIndicatorView!

    let kCharacterCellId = "CharacterCell"
    let kStartLoadingOffset: CGFloat = 200.0

    static func instance() -> MainScreenVC {
        MainScreenVC.initFromStoryboard(name: "MainScreenSB")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = "Marvel characters"
    }

    override func bindViews() {
        viewModel.isLoading?.drive(rx_showLoading).disposed(by: bag)

        viewModel.hasFailed?
            .filter { $0 != nil }
            .map { $0! }
            .map { ($0.localizedDescription, MessageType.error) }
            .drive(rx_showMessage)
            .disposed(by: bag)

        tableView.rx.contentOffset
            .map { self.isNearTheBottomEdge(contentOffset: $0, self.tableView) }
            .filter { $0 }
            .map { _ in }
            .bind(to: viewModel.loadMore)
            .disposed(by: bag)

        bindDataSource()
    }

    func bindDataSource() {
        bindLoadingFooter()

        tableView.register(UINib(nibName: kCharacterCellId, bundle: nil),
                           forCellReuseIdentifier: kCharacterCellId)

        tableView.rowHeight = 240

        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCharacter>(
            configureCell: { [unowned self] _, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: self.kCharacterCellId, for: indexPath) as! CharacterCell
                cell.character = item

                return cell
            }
        )

        viewModel
            .hasSucced?
            .map { [SectionOfCharacter(header: "", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    func bindLoadingFooter() {
        let footerView = LoadingFooter(frame: CGRect(origin: CGPoint.zero, size: CGSize.zero))
        footerView.frame.size.height = 100
        viewModel.isPartialLoading?
            .map { !$0 }
            .drive(footerView.loadIndicator.rx.isHidden)
            .disposed(by: footerView.bag)
        tableView.tableFooterView = footerView
    }
}

extension MainScreenVC {
    var rx_showLoading: AnyObserver<Bool> {
        return Binder(self, binding: { [weak self] _, show in
            self?.loadIndicator.isHidden = !show
        }).asObserver()
    }
}

extension MainScreenVC {
    func isNearTheBottomEdge(contentOffset: CGPoint, _ tableView: UITableView) -> Bool {
        return contentOffset.y +
            tableView.frame.size.height +
            kStartLoadingOffset > tableView.contentSize.height
    }
}
