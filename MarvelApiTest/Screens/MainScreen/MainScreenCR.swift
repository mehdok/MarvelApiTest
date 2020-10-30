//
//  MainScreenCR.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import RxSwift
import DataLayer
import DomainLayer

class MainScreenCR: BaseCoordinator<Void> {
    @Inject private var dataModule: DataModuleType

    let navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewController = MainScreenVC.instance()
        let viewModel = MainScreenVM(marvelCharactersUsecase: dataModule.component())
        viewModel.bindViewDidLoad(viewController.rx.viewDidLoad.asDriver())
        viewController.viewModel = viewModel

        navigationController.viewControllers = [viewController]

        return Observable.never()
    }
}
