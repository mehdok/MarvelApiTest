//
//  AppCoordinator.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let rootNavigation = BaseNavigationController()

        window.rootViewController = rootNavigation
        window.makeKeyAndVisible()

        return showMainScreen(on: rootNavigation)
    }
}

extension AppCoordinator {
    fileprivate func showMainScreen(on rootNavigation: BaseNavigationController)
        -> Observable<Void> {
        rootNavigation.style = .default
        let mainCR = MainScreenCR(navigationController: rootNavigation)
        return coordinate(to: mainCR)
    }
}
