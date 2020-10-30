//
//  MainScreenVM.swift
//  MarvelApiTest
//
//  Created by Mehdok on 10/29/20.
//

import DomainLayer
import RxCocoa
import RxSwift

enum MarvelCharacterResult {
    case loading
    // TODO handle partial loading for loading more content into scsreen
//    case partialLoading
    case success(CharacterDataContainer?)
    case error(Error?)
}

class MainScreenVM: BaseViewModel {
    private let marvelCharactersUsecase: MarvelCharactersUsecase

    var isLoading: Driver<Bool>?
    var hasFailed: Driver<Error?>?
    var hasSucced: Driver<CharacterDataContainer>?

    init(marvelCharactersUsecase: MarvelCharactersUsecase) {
        self.marvelCharactersUsecase = marvelCharactersUsecase
    }

    func bindViewDidLoad(_ vdl: Driver<Void>) {
        // TODO create another driver for loading more data
        let state = vdl
            .flatMap { [unowned self] () -> Driver<MarvelCharacterResult> in
                self.marvelCharactersUsecase.execute(())
                    .observeOn(MainScheduler.instance)
                    .map { (resource: Resource<CharacterDataWrapper>) -> MarvelCharacterResult in
                        switch resource.status {
                        case .success:
                            return .success(resource.data?.data)
                        case .failure:
                            return .error(resource.error?.error)
                        }
                    }
                    .asDriver { error -> Driver<MarvelCharacterResult> in
                        Driver.just(.error(error))
                    }
                    .startWith(.loading)
            }

        isLoading = state
            .map { event in
                switch event {
                case .loading: return true
                default: return false
                }
            }
            .distinctUntilChanged()

        hasFailed = state
            .map { event in
                switch event {
                case let .error(error): return error
                default: return nil
                }
            }
            .filter { $0 != nil }

        hasSucced = state
            .map { event -> CharacterDataContainer? in
                switch event {
                case let .success(characters): return characters
                default: return nil
                }
            }
            .filter { $0 != nil }
            .map { $0! }
    }
}
