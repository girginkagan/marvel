//
//  CharactersResponseModel.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import Foundation
import Unrealm

// MARK: - CharactersResponseModel
struct CharactersResponseModel: Codable {
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int?
    var results: [CharacterResult]?
}

// MARK: - Result
struct CharacterResult: Codable, Realmable {
    var id: Int?
    var name, resultDescription: String?
    var thumbnail: Thumbnail?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail
    }
    
    static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Thumbnail
struct Thumbnail: Codable, Realmable {
    var path: String?
    var thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    static func primaryKey() -> String? {
        return "path"
    }
}
