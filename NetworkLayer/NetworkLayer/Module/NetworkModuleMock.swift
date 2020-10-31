//
//  NetworkModuleMock.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/31/20.
//

import DomainLayer

public struct NetworkModuleMock: NetworkModuleType {
    public init() {}

    public func component() -> MarvelCharacterRepositoryOnline {
        MarvelCharacterRepositoryOnlineImpl(client: component())
    }
}

extension NetworkModuleMock {
    fileprivate func component() -> BaseApiClient {
        ApiClientMock()
    }
}
