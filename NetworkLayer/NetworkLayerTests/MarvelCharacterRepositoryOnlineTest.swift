//
//  MarvelCharacterRepositoryOnlineTest.swift
//  NetworkLayerTests
//
//  Created by Mehdok on 10/31/20.
//

import DomainLayer
@testable import NetworkLayer
import RxBlocking
import RxSwift
import XCTest

class MarvelCharacterRepositoryOnlineTest: XCTestCase {
    var repository: MarvelCharacterRepositoryOnline!
    
    override func setUp() {
        super.setUp()
        repository = MarvelCharacterRepositoryOnlineImpl(client: ApiClientMock())
    }
    
    func testReceivedData() throws {
        let result = try repository.getCharacters(limit: 0, offset: 0) .toBlocking().first()

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
            XCTAssertTrue(type(of: result!.error!) == MarvelError.self)
        }
    }

}
