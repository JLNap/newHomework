//
//  yotubeCloneTestings.swift
//  yotubeCloneTestings
//
//  Created by Андрей Чучупал on 02.12.2025.
//

@testable import yotubeClone
import XCTest

final class MockNetworkManager: NetworkManagerProtocol {
    var stubResults: [Results] = []
    var shouldReturnError = false
    
    func fetchCharacters(completion: @escaping (Result<[yotubeClone.Results], any Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 1, userInfo: nil)))
        } else {
            completion(.success(stubResults))
        }
    }
}

final class MainPresenterTests: XCTestCase {
    var sut: MainPresenter!
    var mockNetwork: MockNetworkManager!
    var onUpdateCalled = false
    
    override func setUp() {
        super.setUp()
        mockNetwork = MockNetworkManager()
        sut = MainPresenter(networkService: mockNetwork)
        sut.onUpdate = { [weak self] in
            self?.onUpdateCalled = true
        }
        onUpdateCalled = false
    }
    
    override func tearDown() {
        sut = nil
        mockNetwork = nil
        onUpdateCalled = false
        super.tearDown()
    }
    
    func test_loadCharacters_success_setsCharacters_andCallsOnUpdate() {
        let character = Results(id: 1, name: "Rick", gender: "Male", image: "", status: CharacterStatus.alive.rawValue)
        mockNetwork.stubResults = [character]
        
        sut.loadCharacters()
        
        let expectation =  XCTestExpectation(description: "Wait for onUpdate")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(sut.characters.count, 1)
        XCTAssertEqual(sut.characters.first?.name, "Rick")
        XCTAssertTrue(onUpdateCalled)
    }
}
