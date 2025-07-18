//
//  MovieResponse.swift
//  Discoverly
//
//  Created by Özgün Şimşek on 3.07.2025.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Content]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
}
