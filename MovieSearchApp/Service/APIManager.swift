//
//  APIManager.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import Foundation

class APIManager: APIManagerProtocol{
    
    func fetchSearchMovie(url: URL, completion: @escaping (Result<[Movie], CustomError>) -> ()) {
        URLSession.shared.dataTask(with: url){ data, response, Error in
            guard let data = data else{
                return
            }
            if let decodedData = try? JSONDecoder().decode(SearchResult.self, from: data){
                let movies = decodedData.search
                completion(.success(movies))
            }else{
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchMovieDetail(for id: String, completion: @escaping (Result<MovieDetail, CustomError>) -> ()) {
        if let url = URL(string: Constants.Urls.detailMovieExtension + id) {
            URLSession.shared.dataTask(with: url){ data, response, Error in
                guard let data = data else{
                    return
                }
                if let decodedData = try? JSONDecoder().decode(MovieDetail.self, from: data){
                    completion(.success(decodedData))
                } else {
                    let dataString = String(data: data, encoding: .utf8)
                    print("Failed to decode data: \(String(describing: dataString))")
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
    }
}

    

    

