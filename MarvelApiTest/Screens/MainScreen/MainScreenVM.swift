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
    // TODO: handle partial loading for loading more content into scsreen
//    case partialLoading
    case success([Character]?)
    case error(Error?)
}

class MainScreenVM: BaseViewModel {
    private let marvelCharactersUsecase: MarvelCharactersUsecase

    var isLoading: Driver<Bool>?
    var hasFailed: Driver<Error?>?
    var hasSucced: Driver<[Character]>?

    let loadMore: AnyObserver<Void>
    private let didLoadMore: Driver<Void>

    private var characters = [Character]()
    private let kLimitPerPage = 20

    init(marvelCharactersUsecase: MarvelCharactersUsecase) {
        self.marvelCharactersUsecase = marvelCharactersUsecase

        let loadPublisher = PublishSubject<Void>()
        loadMore = loadPublisher.asObserver()
        didLoadMore = loadPublisher.asDriver(onErrorJustReturn: ())
    }

    func bindViewDidLoad(_ vdl: Driver<Void>) {
        let state = Driver.merge(vdl, didLoadMore)
            .flatMap { [unowned self] () -> Driver<MarvelCharacterResult> in
                self.marvelCharactersUsecase
                    .execute(CharacterUsecaseParam(kLimitPerPage, characters.count))
                    .observeOn(MainScheduler.instance)
                    .map { (resource: Resource<CharacterDataWrapper>) -> MarvelCharacterResult in
                        switch resource.status {
                        case .success:
                            return .success(resource.data?.data?.results)
                        case .failure:
                            return .error(resource.error?.error)
                        }
                    }
                    .asDriver { error -> Driver<MarvelCharacterResult> in
                        Driver.just(.error(error))
                    }
                    .startWith(.loading)
            } // .debug()

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
            .map { event -> [Character]? in
                switch event {
                case let .success(characters): return characters
                default: return nil
                }
            }
            .filter { $0 != nil }
            .map { [unowned self] in
                self.characters.append(contentsOf: $0!)
                return self.characters
            }
    }
}
