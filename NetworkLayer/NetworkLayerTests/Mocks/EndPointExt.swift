//
//  EndPointExt.swift
//  NetworkLayerTests
//
//  Created by Mehdok on 10/31/20.
//

@testable import NetworkLayer

extension EndPoint {
    var mockJsonFile: String {
        switch self {
        case .characters:
            return "CharactersData"
        }
    }
}
