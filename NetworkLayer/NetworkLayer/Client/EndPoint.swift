//
//  EndPoint.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

import UIKit

enum EndPoint: String {
    case characters = "characters"
}

extension EndPoint {
    var method: String {
        switch self {
        case .characters:
            return "GET"
        }
    }
}
