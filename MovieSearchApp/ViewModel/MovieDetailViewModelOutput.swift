//
//  MovieDetailViewModelOutput.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import Foundation

protocol MovieDetailViewModelOutput: AnyObject{
    func updateView(search: MovieDetail?, error: String?)
}
