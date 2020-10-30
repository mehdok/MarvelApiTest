//
//  DetailScreenVC.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/30/20.
//

import Kingfisher
import RxCocoa
import RxSwift
import UIKit

class DetailScreenVC: BaseViewController<DetailScreenVM> {
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var characterName: UILabel!
    @IBOutlet var characterDescription: UITextView!

    static func instance() -> DetailScreenVC {
        DetailScreenVC.initFromStoryboard(name: "DetailScreenSB")
    }

    override func bindViews() {
        // set navigation title from character name
        viewModel.characterName?.drive(navigationItem.rx.title).disposed(by: bag)
        viewModel.characterName?.drive(characterName.rx.text).disposed(by: bag)
        viewModel.characterImage?.filter { $0 != nil }.map { $0! }.drive(rx_loadCharacterImage).disposed(by: bag)
        viewModel.characterDescription?.drive(characterDescription.rx.text).disposed(by: bag)
    }
}

extension DetailScreenVC {
    // a binder to load city image whenever it's available
    public var rx_loadCharacterImage: AnyObserver<String> {
        return Binder(self, binding: { [weak self] _, url in
            self?.characterImage.kf.indicatorType = .activity
            self?.characterImage.kf.setImage(with: URL(string: url)!)
        }).asObserver()
    }
}
