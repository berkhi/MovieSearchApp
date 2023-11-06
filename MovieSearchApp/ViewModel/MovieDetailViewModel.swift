//
//  MovieDetailViewModel.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import Foundation

class MovieDetailViewModel{
    private let movieDetailService: APIManagerProtocol
    weak var movieDetailOutput: MovieDetailViewModelOutput?
    
    init(movieDetailService: APIManagerProtocol) {
        self.movieDetailService = movieDetailService
    }
    
    func fetchMovieDetail(for id: String){
        movieDetailService.fetchMovieDetail(for: id, completion: { result in
                switch result {
                case .success(let movie):
                    print("Data received:", movie)
                    self.movieDetailOutput?.updateView(search: movie, error: nil)
                case .failure(let customError):
                    switch customError{
                    case .decodingError:
                        self.movieDetailOutput?.updateView(search: nil, error: "Error! Decoding error.")
                    case .networkError:
                        self.movieDetailOutput?.updateView(search: nil, error: "Error! Network error.")
                    case .serverError:
                        self.movieDetailOutput?.updateView(search: nil, error: "Error! Server error.")
                    case .urlError:
                        self.movieDetailOutput?.updateView(search: nil, error: "Error! URL error.")
                    }
                }
            
        })
    }
}
