//
//  AppDelegate.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import RxSwift
import UIKit

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
    override func services() -> [ApplicationService] {
        [
            DependenciesApplicationService(),
            UIApplicationService(window: window),
        ]
    }
}
