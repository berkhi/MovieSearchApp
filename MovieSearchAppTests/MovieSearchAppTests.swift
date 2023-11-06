//
//  MovieSearchAppTests.swift
//  MovieSearchAppTests
//
//  Created by BerkH on 4.11.2023.
//

import XCTest
@testable import MovieSearchApp

final class MovieSearchAppTests: XCTestCase {
    
    private var movieViewModel: MovieViewModel!
    private var movieDetailViewModel: MovieDetailViewModel!
    
    private var webService: MockWebService!
    
    private var movieOutput: MockMovieViewModelOutput!
    private var movieDetailOutput: MockMovieDetailViewModelOutput!

    override func setUpWithError() throws {
        webService = MockWebService()
        movieViewModel = MovieViewModel(movieService: webService, movieOutput: MockMovieViewModelOutput())
        movieOutput = MockMovieViewModelOutput()
        movieViewModel.movieOutput = movieOutput
        
        movieDetailViewModel = MovieDetailViewModel(movieDetailService: webService)
        movieDetailOutput = MockMovieDetailViewModelOutput()
        movieDetailViewModel.movieDetailOutput = movieDetailOutput
        
        
    }
    
    override func tearDownWithError() throws {
        movieViewModel = nil
        movieDetailViewModel = nil
        webService = nil
    }

    func testFetchMovie_whenAPISuccess_showsMovie() throws{
        let movie = SearchResult(search: [Movie(title: "Batman Begins", year: "2005", imdbID: "", poster: "")], totalResults: "", response: "")
    }
    func testFetchMovieDetail_whenAPISuccess_showsMovie() throws{
        let movieDetail = MovieDetail(title: "Batman Begins", year: "2005", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", ratings: [Rating(source: "", value: "")], metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "", dvd: "", boxOffice: "", production: "", website: "", response: "")
    }

    class MockWebService : APIManagerProtocol {
        var fetchSearchMovieMockResult: Result<[MovieSearchApp.Movie], CustomError>?
        var fetchMovieDetailMockResult: Result<MovieSearchApp.MovieDetail, CustomError>?
        
        func fetchSearchMovie(url: URL, completion: @escaping (Result<[MovieSearchApp.Movie], MovieSearchApp.CustomError>) -> ()) {
            if let result = fetchSearchMovieMockResult {
                completion(result)
            }
        }
        func fetchMovieDetail(for id: String, completion: @escaping (Result<MovieSearchApp.MovieDetail, MovieSearchApp.CustomError>) -> ()) {
            if let result = fetchMovieDetailMockResult{
                completion(result)
            }
        }
    }
    
    class MockMovieViewModelOutput : MovieViewModelOutput {
        var movie: Movie?
        func updateView(search: [MovieSearchApp.Movie]?, error: String?) {
            if let movie{
                self.movie = movie
            }
        }
        
    }
    class MockMovieDetailViewModelOutput : MovieDetailViewModelOutput {
        var movieDetail: MovieDetail?
        func updateView(search: MovieSearchApp.MovieDetail?, error: String?) {
            if let movieDetail{
                self.movieDetail = movieDetail
            }
        }
        
        
    }

}
