//
//  ComicsResponseModel.swift
//  marvel
//
//  Created by Kagan Girgin on 1/29/22.
//

import Foundation

// MARK: - ComicsResponseModel
struct ComicsResponseModel: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: ComicsDataClass?
}

// MARK: - ComicsDataClass
struct ComicsDataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [ComicResult]?
}

// MARK: - Result
struct ComicResult: Codable {
    let thumbnail: Thumbnail?

    enum CodingKeys: String, CodingKey {
        case thumbnail
    }
}
