//
//  AppDelegate.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
    override func services() -> [ApplicationService] {
        [
            UIApplicationService(window: window),
        ]
    }
}
