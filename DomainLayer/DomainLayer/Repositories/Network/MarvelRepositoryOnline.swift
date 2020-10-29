//
//  MarvelRepositoryOnline.swift
//  DomainLayer
//
//  Created by Mehdok on 10/29/20.
//

import RxSwift

public protocol MarvelRepositoryOnline {
    func getCharacters() -> Observable<Resource<CharacterDataWrapper>>
}
