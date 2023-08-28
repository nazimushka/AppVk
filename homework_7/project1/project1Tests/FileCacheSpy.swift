//
//  FileCacheSpy.swift
//  project1
//
//  Created by Алекс Фитнес on 27.08.2023.
//

import Foundation
@testable import project1
final class FileCacheSpy: FileCacheProtocol{
    private(set) var isAddFriendsWasCalled = false
    private(set) var isFetchFriendsWasCalled = false
    private(set) var isFetchFriendDateWasCalled = false
    private(set) var isAddFriendDateWasCalled = false
    func addFriends(friends: [project1.Friend]) {
        isAddFriendsWasCalled = true
    }
    
    func fetchFriends() -> [project1.Friend] {
        isFetchFriendsWasCalled = true
        return []
    }
    
    func fetchFriendDate() -> Date? {
        isFetchFriendDateWasCalled = true
        return nil
    }
    
    func addFriendDate() {
        isAddFriendDateWasCalled = true
    }
    
    
}

