//
//  NetworkServiceSpy.swift
//  project1
//
//  Created by Алекс Фитнес on 27.08.2023.
//

import Foundation
@testable import project1
final class NetworkServiceSpy: NetworkServiceProtocol{
    private(set) var isGetFriendsWasCalled = false
    
    func getFriends(completion: @escaping (Result<[project1.Friend], Error>) -> Void) {
        isGetFriendsWasCalled = true
    }
    
    
}
