//
//  DetailScreenVC.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/30/20.
//


class DetailScreenVC: BaseViewController<DetailScreenVM> {

    static func instance() -> DetailScreenVC {
        DetailScreenVC.initFromStoryboard(name: "DetailScreenSB")
    }
    
    override func bindViews() {
        //TODO
    }

}
