//
//  FriendsModel.swift
//  project1
//
//  Created by Алекс Фитнес on 14.08.2023.
//

struct FriendsModel: Decodable {
    var response: Friends
}
struct Friends: Decodable {
    var items: [Friend]
}
struct Friend: Decodable {
    var id: Int
    var firstName: String?
    var lastName: String?
    var photo: String?
    var online: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_400_orig"
        case online
    }
}

