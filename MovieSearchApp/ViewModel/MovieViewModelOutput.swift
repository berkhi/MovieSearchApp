//
//  MovieViewModelOutput.swift
//  MovieSearchApp
//
//  Created by BerkH on 5.11.2023.
//

import Foundation

protocol MovieViewModelOutput: AnyObject{
    func updateView(search: [Movie]?, error: String?)
}
