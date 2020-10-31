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
    case success([Character]?)
    case error(Error?)
}

class MainScreenVM: BaseViewModel {
    private let marvelCharactersUsecase: MarvelCharactersUsecase

    var isLoading: Driver<Bool>?
    var isPartialLoading: Driver<Bool>?
    var hasFailed: Driver<Error?>?
    var hasSucced: Driver<[Character]>?
    
    let openDetailScreen: AnyObserver<Character>
    let didOpenDetailScreen: Observable<Character>
    
    let loadMore: AnyObserver<Void>
    private let didLoadMore: Driver<Void>

    private var characters = [Character]()
    private let kLimitPerPage = 20 // < 100

    // This flag indicate weather we are loading more content or not
    var loading = false
    var endOfCharactersReached = false

    init(marvelCharactersUsecase: MarvelCharactersUsecase) {
        self.marvelCharactersUsecase = marvelCharactersUsecase

        let loadPublisher = PublishSubject<Void>()
        loadMore = loadPublisher.asObserver()
        didLoadMore = loadPublisher.asDriver(onErrorJustReturn: ())
        
        let detailPublisher = PublishSubject<Character>()
        openDetailScreen = detailPublisher.asObserver()
        didOpenDetailScreen = detailPublisher.asObservable()
    }

    func bindViewDidLoad(_ vdl: Driver<Void>) {
        let state = Driver.merge(vdl, didLoadMore)
            .filter { [unowned self] _ in !self.loading && !self.endOfCharactersReached }
            .map {_ in self.loading = true }
            .flatMap { [unowned self] _ -> Driver<MarvelCharacterResult> in
                self.marvelCharactersUsecase
                    .execute(CharacterUsecaseParam(kLimitPerPage, characters.count))
                    .observeOn(MainScheduler.instance)
                    .map { (resource: Resource<CharacterDataWrapper>) -> MarvelCharacterResult in
                        loading = false
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
            }//.debug("load_state: \(characters.count)", trimOutput: true)

        isLoading = state
            .map { event in
                switch event {
                // it is first loading only if characters count is zero
                case .loading: return self.characters.isEmpty
                default: return false
                }
            }
            .distinctUntilChanged()

        isPartialLoading = state
            .map { [unowned self] event in
                switch event {
                // it is partial loading if it is loading and characters count is more than one
                case .loading: return !self.characters.isEmpty
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
                self.endOfCharactersReached = $0!.isEmpty
                self.characters.append(contentsOf: $0!)
                return self.characters
            }
    }
}
