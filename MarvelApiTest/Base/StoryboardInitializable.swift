//
//  StoryboardInitializable.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

public protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

public extension StoryboardInitializable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }

    static func initFromStoryboard(name: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle(for: self))
        return storyboard
            .instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
