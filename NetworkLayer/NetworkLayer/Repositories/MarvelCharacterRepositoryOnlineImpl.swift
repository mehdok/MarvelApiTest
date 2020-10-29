//
//  MarvelCharacterRepositoryOnlineImpl.swift
//  NetworkLayer
//
//  Created by Mehdok on 10/29/20.
//

import DomainLayer
import RxSwift

struct MarvelCharacterRepositoryOnlineImpl: MarvelCharacterRepositoryOnline {
    let client: BaseApiClient

    func getCharacters() -> Observable<Resource<CharacterDataWrapper>> {
        let characters: Observable<Resource<OCharacterDataWrapper>> =
            client.call(.characters, headers: nil, queries: nil, body: nil)

        return characters
            .flatMap { resource -> Observable<Resource<CharacterDataWrapper>> in
                switch resource.status {
                case .success:
                    return Observable.just(Resource.success(data: resource.data!.entity))
                case .failure:
                    return Observable.just(Resource.error(error: resource.error!))
                }
            }
    }
}