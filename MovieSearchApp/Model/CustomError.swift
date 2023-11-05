//
//  CustomError.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import Foundation

enum CustomError: Error {
    case urlError
    case serverError
    case decodingError
    case networkError
}
