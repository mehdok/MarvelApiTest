//
//  MainScreenCR.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import RxSwift
import DataLayer
import DomainLayer
import RxCocoa

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
        // handle opening detail screen, triggered from viewModel Observable
        viewModel.didOpenDetailScreen
            .map { [unowned self] in (self.navigationController, $0) }
            .bind(to: rx_openDetailScreen)
            .disposed(by: bag)
        viewController.viewModel = viewModel

        navigationController.viewControllers = [viewController]

        return Observable.never()
    }
}

extension MainScreenCR {
    public var rx_openDetailScreen: AnyObserver<(UINavigationController, Character)> {
        return Binder(self, binding: { [unowned self] _, data in
            let (root, character) = data
            let coordinator = DetailScreenCR(rootNavigation: root, character: character)
            self.coordinate(to: coordinator)
                // subscribe and dispose to let go of coordinator when it returns
                .subscribe { _ in }.disposed(by: self.bag)
        }).asObserver()
    }
}
