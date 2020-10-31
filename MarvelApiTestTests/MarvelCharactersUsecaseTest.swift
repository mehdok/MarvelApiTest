//
//  MarvelCharactersUsecaseTest.swift
//  MarvelApiTestTests
//
//  Created by Mehdok on 10/31/20.
//

import DomainLayer
@testable import MarvelApiTest
import NetworkLayer
import RxBlocking
import RxSwift
import XCTest

class MarvelCharactersUsecaseTest: XCTestCase {
    private let dependencies = Dependencies {
        Module { DomainModule() as DomainModuleType }
        Module { NetworkModuleMock() as NetworkModuleType }
    }

    @Inject private var domainModule: DomainModuleType
    @Inject private var networkModule: NetworkModuleType
    
    var charcterUsecase: MarvelCharactersUsecase!
    
    override func setUp() {
        super.setUp()
        dependencies.build()
        
        let netScheduler: NetworkScheduler = domainModule.component()
        
        charcterUsecase = MarvelCharactersUsecase(marvelCharacterRepository: networkModule.component(),
                                                  backgroundScheduler: netScheduler.scheduler,
                                                  mainScheduler: MainScheduler.instance)
        
    }
    
    func testReceivedData() throws {
        let result = try charcterUsecase.execute(CharacterUsecaseParam(0,0)).toBlocking().first()
        
        XCTAssertNotNil(result)

        switch result!.status {
        case .success:
            XCTAssertNotNil(result?.data)
            let characters = (result!.data!.data?.results)!
            XCTAssertTrue(type(of: characters) == [Character].self)
            XCTAssertEqual(characters.count, 20)
            XCTAssertEqual(characters.first!.name, "3-D Man")
        case .failure:
            XCTAssertNotNil(result!.error)
        }
    }
}
