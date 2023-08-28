//
//  PhotosModel.swift
//  project1
//
//  Created by Алекс Фитнес on 14.08.2023.
//

struct PhotosModel: Decodable {
    var response: Photos
}
struct Photos: Decodable {
    var items: [Photo]
}
struct Photo: Decodable {
    var id: Int
    var text: String?
    var sizes: [Sizes]
}
struct Sizes: Codable {
    var url: String
}
