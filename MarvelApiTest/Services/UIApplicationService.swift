//
//  UIApplicationService.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import RxSwift
import UIKit

class UIApplicationService: ApplicationService {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    // TODO: dispose bag when app is terminated
    private let disposeBag = DisposeBag()

    init(window: UIWindow?) {
        self.window = window
    }

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        startFirstPage()
        return true
    }
}

extension UIApplicationService {
    func startFirstPage() {
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
    }
}
