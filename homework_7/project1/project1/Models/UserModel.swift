//
//  UserModel.swift
//  project1
//
//  Created by Алекс Фитнес on 27.08.2023.
//

struct UserModel: Decodable {
    var response: [User]
}
struct User: Decodable {
    var firstName: String?
    var lastName: String?
    var photo: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_400_orig"
    }
}

