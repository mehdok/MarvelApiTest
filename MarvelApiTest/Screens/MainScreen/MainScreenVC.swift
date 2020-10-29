//
//  MainScreenVC.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

class MainScreenVC: BaseViewController<MainScreenVM> {

    static func instance() -> MainScreenVC {
        MainScreenVC.initFromStoryboard(name: "MainScreenSB")
    }
    
    override func bindViews() {
        //TODO
    }
}
