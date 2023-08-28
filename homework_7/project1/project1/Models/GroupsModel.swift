//
//  GroupsModel.swift
//  project1
//
//  Created by Алекс Фитнес on 14.08.2023.
//

struct GroupsModel: Decodable {
    var response: Groups
}
struct Groups: Decodable {
    var items: [Group]
}
struct Group: Codable {
    var id: Int
    var name: String?
    var photo: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo_50"
        case description
    }
}

