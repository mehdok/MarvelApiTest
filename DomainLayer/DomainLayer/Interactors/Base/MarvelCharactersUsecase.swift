//
//  MarvelCharactersUsecase.swift
//  DomainLayer
//
//  Created by Mehdok on 10/29/20.
//

import RxSwift

public struct MarvelCharactersUsecase: ObservableUseCase {
    let marvelCharacterRepository: MarvelCharacterRepositoryOnline
    let backgroundScheduler: SchedulerType
    let mainScheduler: SchedulerType
    
    public init(marvelCharacterRepository: MarvelCharacterRepositoryOnline,
                backgroundScheduler: SchedulerType,
                mainScheduler: SchedulerType)
    {
        self.marvelCharacterRepository = marvelCharacterRepository
        self.backgroundScheduler = backgroundScheduler
        self.mainScheduler = mainScheduler
    }
    
    public typealias Output = Resource<CharacterDataWrapper>
    
    public typealias Input = Void
    
    public func execute(_ input: Void) -> Observable<Resource<CharacterDataWrapper>> {
        return marvelCharacterRepository.getCharacters()
            .subscribeOn(backgroundScheduler)
            .observeOn(mainScheduler)
    }
}
