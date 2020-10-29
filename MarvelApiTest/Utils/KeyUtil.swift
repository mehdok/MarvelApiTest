//
//  KeyUtil.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import DomainLayer
import UIKit

class KeyUtil: NSObject {
    static var apiKeys: Keys {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let keysData = FileManager.default.contents(atPath: path),
            let keys = try? PropertyListDecoder().decode(Keys.self, from: keysData)
        else {
            preconditionFailure("Can not retrieve api keys")
        }

        return keys
    }
}
