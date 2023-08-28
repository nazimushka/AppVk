//
//  FriendsControllerTests.swift
//  project1
//
//  Created by Алекс Фитнес on 27.08.2023.
//

import Foundation
import XCTest

@testable import project1
final class FriendsControllerTests: XCTestCase {
    private var friendsController: FriendsController!
    private var networkService: NetworkServiceSpy!
    private var fileCache: FileCacheSpy!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkServiceSpy()
        fileCache = FileCacheSpy()
        friendsController = FriendsController(networkService: networkService, models: [], fileCache: fileCache)
    }
    
    override func tearDown() {
        friendsController = nil
        networkService = nil
        fileCache = nil
        super.tearDown()
    }
     
    func testGetFriends() {
        friendsController.getFriends()
        XCTAssertTrue(networkService.isGetFriendsWasCalled, "метод не вызван")
    }
    
}

