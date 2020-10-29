//
//  DataModule.swift
//  DataLayer
//
//  Created by Mehdok on 10/29/20.
//
import DomainLayer
import NetworkLayer
import RxSwift

public protocol DataModuleType {
    func component() -> MarvelCharactersUsecase
}

public struct DataModule: DataModuleType {
    @Inject private var networkModule: NetworkModuleType
    @Inject private var domainModule: DomainModuleType

    public init() {}

    public func component() -> MarvelCharactersUsecase {
        let netScheduler: NetworkScheduler = domainModule.component()

        return MarvelCharactersUsecase(
            marvelCharacterRepository: networkModule.component(),
            backgroundScheduler: netScheduler.scheduler,
            mainScheduler: MainScheduler.instance)
    }
}
