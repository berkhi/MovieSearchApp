//
//  Constants.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let baseUrl = "https://www.omdbapi.com/?apikey=e6132c19&"
        static let searchMovieExtension = "\(baseUrl)s="
        static let detailMovieExtension = "\(baseUrl)i="
    }
    
}
