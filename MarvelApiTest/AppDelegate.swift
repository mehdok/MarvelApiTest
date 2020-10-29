//
//  AppDelegate.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import UIKit
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    public var window: UIWindow?

    private var appCoordinator: AppCoordinator!
    // TODO: dispose bag when app is terminated
    private let disposeBag = DisposeBag()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startFirstPage()
        return true
    }

}

extension AppDelegate {
    func startFirstPage() {
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
    }
}


