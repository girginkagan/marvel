//
//  CharactersResponseModel.swift
//  marvel
//
//  Created by Kagan Girgin on 1/28/22.
//

import Foundation

// MARK: - CharactersResponseModel
struct CharactersResponseModel: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int?
    var results: [CharacterResult]?
}

// MARK: - Result
struct CharacterResult: Codable {
    let id: Int?
    let name, resultDescription: String?
    let thumbnail: Thumbnail?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail, comics, series, stories, events
    }
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String?
    let name, type: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String?
    let url: String?
}
