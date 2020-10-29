//
//  BaseNavigationController.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

open class BaseNavigationController: UINavigationController {
    public var style: UIStatusBarStyle = .lightContent

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return style
    }
}
