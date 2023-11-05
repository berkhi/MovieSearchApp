//
//  APIManagerProtocol.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import Foundation

protocol APIManagerProtocol {
    func fetchSearchMovie(url: URL, completion: @escaping (Result<[Movie], CustomError>) -> ())
    func fetchMovieDetail(for id: String, completion: @escaping (Result<MovieDetail, CustomError>) -> ())
}
