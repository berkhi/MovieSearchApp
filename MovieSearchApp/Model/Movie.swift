//
//  Movie.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import Foundation

struct SearchResult: Codable {
    let search: [Movie]
    let totalResults: String
    let response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

struct Movie: Codable {
    let title: String
    let year: String
    let imdbID: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
    }
}

