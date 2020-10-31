//
//  BaseViewModel.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import UIKit
import RxSwift

/**
 There is a little workflow for future readers:
 The **Outputs** are *Observables* like `let didCancel: Observable<Void>` so the Coordinator can listen to them,
 Actually they are for returning different results from ViewModel

 The **Inputs** are *Observers* like `let cancel: AnyObserver<Void>` who can trigger the *Outputs*
 So viewModel call one of the inputs and Coordinator will listen to output for getting results

 The **Middle Mans** are *Drivers* like `var isGoogleLoading: Driver<Bool>?` who bind to the view and taking
 action based on that and finally binds to Something meaningfull, eg. updating UI or triggering one of the inputs
 */
open class BaseViewModel {
    var poppedFromNavigationStack: AnyObserver<Void>
    public var didPoppedFromNavigationStack: Observable<Void>

    public init() {
        let _poppedFromNavigationStack = PublishSubject<Void>()
        poppedFromNavigationStack = _poppedFromNavigationStack.asObserver()
        didPoppedFromNavigationStack = _poppedFromNavigationStack.asObservable()
    }

    deinit {
        Log.i("\(String(describing: self))")
    }
}
