//
//  Content.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 3.07.2025.
//

import Foundation

struct Content: Decodable {
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String
    let genreIDs: [Int]

    var category: String {
        if genreIDs.contains(28) {
            return "Action"
        } else if genreIDs.contains(35) {
            return "Comedy"
        } else if genreIDs.contains(18) {
            return "Drama"
        } else if genreIDs.contains(27) {
            return "Horror"
        } else if genreIDs.contains(53) {
            return "Thriller"
        } else if genreIDs.contains(878) {
            return "Sci-Fi"
        } else {
            return "Uncategorized"
        }
    }

    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case genreIDs = "genre_ids"
    }
}
