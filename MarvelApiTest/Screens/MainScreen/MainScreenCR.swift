//
//  MainScreenCR.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import RxSwift

class MainScreenCR: BaseCoordinator<Void> {
    let navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewController = MainScreenVC.instance()
        let viewModel = MainScreenVM()
        viewController.viewModel = viewModel

        navigationController.viewControllers = [viewController]

        return Observable.never()
    }
}
