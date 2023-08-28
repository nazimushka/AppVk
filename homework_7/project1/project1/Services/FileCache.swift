//
//  FileCache.swift
//  project1
//
//  Created by Алекс Фитнес on 27.08.2023.
//

import Foundation
import CoreData

protocol FileCacheProtocol {
    func addFriends(friends: [Friend])
    func fetchFriends() -> [Friend]
    func fetchFriendDate() -> Date?
    func addFriendDate()
}

final class FileCache: FileCacheProtocol {
    lazy var persistentContaner:
    NSPersistentContainer = {
        let persistentContaner = NSPersistentContainer(name: "DataModel")
        persistentContaner.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                print(error)
            }
        })
        return persistentContaner
    }()

    func save() {
        if persistentContaner.viewContext.hasChanges {
            do {
                try
                persistentContaner.viewContext.save()
            } catch {
                print(error)
            }
        }
    }

    func addFriends(friends: [Friend]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendModelCD")
        for friend in friends {
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [friend.id])
            let result = try?persistentContaner.viewContext.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }
            let friendModel = FriendModelCD(context: persistentContaner.viewContext)
            friendModel.id = Int64(friend.id)
            friendModel.firstName = friend.firstName
            friendModel.lastName = friend.lastName
            friendModel.photo = friend.photo
            friendModel.online = Int64(friend.online ?? 0)
        }
        save()
        addFriendDate()
    }
    

    func fetchFriends() -> [Friend] {
        let fetchRequest:
        NSFetchRequest<FriendModelCD> = FriendModelCD.fetchRequest()
        guard let friends = try?persistentContaner.viewContext.fetch(fetchRequest) else {
            return []
        }
        var newFriends: [Friend] = []
        for friend in friends {
            newFriends.append(Friend(id: Int(friend.id), firstName: friend.firstName, lastName: friend.lastName, photo: friend.photo, online: Int(friend.online)))
        }
        return newFriends
    }
    

    func addFriendDate() {
        _ = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendsDate")
        let date = FriendsDate(context: persistentContaner.viewContext)
        date.date = Date()
        save()
    }
    

    func fetchFriendDate() -> Date? {
        let fetchRequest: NSFetchRequest<FriendsDate> = FriendsDate.fetchRequest()
        guard let date = try?persistentContaner.viewContext.fetch(fetchRequest) else {
            return nil
        }
        return date.first?.date
    }
    

    func addGroups(groups: [Group]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupModelCD")
        for group in groups {
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [group.id])
            let result = try?persistentContaner.viewContext.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }
            let groupModel = GroupModelCD(context: persistentContaner.viewContext)
            groupModel.id = Int64(group.id)
            groupModel.caption = group.description
            groupModel.name = group.name
            groupModel.photo = group.photo
        }
        save()
        addGroupDate()
    }
    
    

    func fetchGroups() -> [Group] {
        let fetchRequest:
        NSFetchRequest<GroupModelCD> = GroupModelCD.fetchRequest()
        guard let groups = try?persistentContaner.viewContext.fetch(fetchRequest) else {
            return []
        }
        var newGroups: [Group] = []
        for group in groups {
            newGroups.append(Group(id: Int(group.id), name: group.name, photo: group.photo, description: group.caption))
        }
        return newGroups
    }
    
    
    func addGroupDate() {
        _ = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupDate")
        let date = GroupDate(context: persistentContaner.viewContext)
        date.date = Date()
        save()
    }
    

    func fetchGroupdDate() -> Date? {
        let fetchRequest: NSFetchRequest<GroupDate> = GroupDate.fetchRequest()
        guard let date = try?persistentContaner.viewContext.fetch(fetchRequest) else {
            return nil
        }
        return date.first?.date
    }
}
