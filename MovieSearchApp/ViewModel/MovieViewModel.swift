//
//  MovieViewModel.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import Foundation

class MovieViewModel{
    private let movieService: APIManagerProtocol
    var movieOutput: MovieViewModelOutput
    
    init(movieService: APIManagerProtocol, movieOutput: MovieViewModelOutput) {
        self.movieService = movieService
        self.movieOutput = movieOutput
    }
    
    func fetchMovieSearchs(url: URL){
        movieService.fetchSearchMovie(url: url) { result in
            DispatchQueue.main.async(){
                switch result {
                case .success(let movie):
//                    print("Data received:", movie)
                    self.movieOutput.updateView(search: movie, error: nil)
                case .failure(let customError):
                    switch customError{
                    case .decodingError:
                        self.movieOutput.updateView(search: nil, error: "Error! Decoding error.")
                    case .networkError:
                        self.movieOutput.updateView(search: nil, error: "Error! Network error.")
                    case .serverError:
                        self.movieOutput.updateView(search: nil, error: "Error! Server error.")
                    case .urlError:
                        self.movieOutput.updateView(search: nil, error: "Error! URL error.")
                    }
                }
            }
        }
    }
    
}
