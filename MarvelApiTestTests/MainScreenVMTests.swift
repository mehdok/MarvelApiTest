//
//  MainScreenVMTests.swift
//  MarvelApiTestTests
//
//  Created by Mehdok on 10/31/20.
//

import DomainLayer
@testable import MarvelApiTest
import NetworkLayer
import RxBlocking
import RxCocoa
import RxSwift
import RxTest
import XCTest

class MainScreenVMTests: XCTestCase {
    private let dependencies = Dependencies {
        Module { DomainModule() as DomainModuleType }
        Module { NetworkModuleMock() as NetworkModuleType }
    }

    @Inject private var domainModule: DomainModuleType
    @Inject private var networkModule: NetworkModuleType
    
    var characterUsecase: MarvelCharactersUsecase!
    var viewModel: MainScreenVM!
    var bag: DisposeBag!

    // fake view did load observer and driver to simulate viewDidLoad func
    var vld: AnyObserver<Void>!
    var viewDidLoadDriver: Driver<Void>!
    
    override func setUp() {
        super.setUp()
        dependencies.build()

        bag = DisposeBag()
        let vldPublisher = PublishSubject<Void>()
        vld = vldPublisher.asObserver()
        viewDidLoadDriver = vldPublisher.asDriver(onErrorJustReturn: ())
    }
    
    func testLoading() {
        bag = DisposeBag()
        
        let scheduler = TestScheduler(initialClock: 0)
        viewModel = getViewModel(scheduler: scheduler)
        
        let trigger = scheduler.createHotObservable([.next(0, ())])
        let isLoadingResult = scheduler.createObserver(Bool.self)
        
        // operation starts with loading true then false
        let expected: [Recorded<Event<Bool>>] = [.next(0, true), .next(2, false)]
        
        trigger.bind(to: vld).disposed(by: bag)
        viewModel.isLoading?.drive(isLoadingResult).disposed(by: bag)

        scheduler.start()

        XCTAssertEqual(isLoadingResult.events, expected)
    }
}

extension MainScreenVMTests {
    func getViewModel(scheduler: TestScheduler) -> MainScreenVM {
        characterUsecase = MarvelCharactersUsecase(marvelCharacterRepository: networkModule.component(),
                                                  backgroundScheduler: scheduler,
                                                  mainScheduler: scheduler)

        viewModel = MainScreenVM(marvelCharactersUsecase: characterUsecase)
        viewModel.bindViewDidLoad(viewDidLoadDriver)

        return viewModel
    }
}