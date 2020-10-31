//
//  BaseView.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

import RxSwift

open class BaseView: UIView {
    public var bag = DisposeBag()

    deinit {
        bag = DisposeBag()
    }
}
