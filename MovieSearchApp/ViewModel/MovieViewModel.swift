//
//  MovieViewModel.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import Foundation

class MovieViewModel{
    private let movieService: APIManagerProtocol
    var output: MovieViewModelOutput
    
    init(movieService: APIManagerProtocol, output: MovieViewModelOutput) {
        self.movieService = movieService
        self.output = output
    }
    
    func fetchMovieSearchs(url: URL){
        movieService.fetchSearchMovie(url: url) { result in
            DispatchQueue.main.async(){
                switch result {
                case .success(let movie):
//                    print("Data received:", movie)
                    self.output.updateView(search: movie, error: nil)
                case .failure(let customError):
                    switch customError{
                    case .decodingError:
                        self.output.updateView(search: nil, error: "Error! Decoding error.")
                    case .networkError:
                        self.output.updateView(search: nil, error: "Error! Network error.")
                    case .serverError:
                        self.output.updateView(search: nil, error: "Error! Server error.")
                    case .urlError:
                        self.output.updateView(search: nil, error: "Error! URL error.")
                    }
                }
            }
        }
    }
    
}
