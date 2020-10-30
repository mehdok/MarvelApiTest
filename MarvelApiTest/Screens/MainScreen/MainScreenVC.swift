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
        
        bindDataSource()
    }
    
    func bindDataSource() {
        // hide separator between empty cells
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: kCharacterCellId, bundle: nil),
                           forCellReuseIdentifier: kCharacterCellId)

        tableView.rowHeight = 180
        
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
}

extension MainScreenVC {
    var rx_showLoading: AnyObserver<Bool> {
        return Binder(self, binding: { [weak self] _, show in
            self?.loadIndicator.isHidden = !show
        }).asObserver()
    }
}
