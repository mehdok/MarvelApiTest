//
//  DetailScreenCR.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/30/20.
//

import DomainLayer
import UIKit
import RxSwift

class DetailScreenCR: BaseCoordinator<Void> {
    let rootNavigation: UINavigationController
    let character: Character
    
    init(rootNavigation: UINavigationController, character: Character) {
        self.rootNavigation = rootNavigation
        self.character = character
    }
   
    override func start() -> Observable<Void> {
        let viewController = DetailScreenVC.instance()
        let viewModel = DetailScreenVM(character: character)
        viewController.viewModel = viewModel

        // Push detail vc to navigation stack with default animation
        rootNavigation.pushViewController(viewController, animated: true)

        // Detail scrren has no result to return and it will free to dispose whenever
        // it pops from navigation stack
        return viewModel.didPoppedFromNavigationStack.take(1)
    }
}
