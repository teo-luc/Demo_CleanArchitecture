//
//  MovieViewModel.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Domain

struct MovieItemViewModel {
    //
    let movie: Domain.Movie
    //
    let posterPath  : URL
    let title       : String
    let overview    : String
    let releaseDate : String
    let rating      : String
    
    init(movie: Domain.Movie) {
        // 1
        self.movie       = movie
        // 2
        self.posterPath  = MovieItemViewModel.getPosterURL(from: movie.posterPath)
        self.title       = movie.originalTitle
        self.overview    = movie.overview
        self.releaseDate = movie.releaseDate /* Format       : YYYY-MM-DD */
        self.rating      = MovieItemViewModel.getRating(from: movie.voteAverage)
        //
    }
}

extension MovieItemViewModel {
    // TODO: hardcode
    private static func getPosterURL(from posterPath: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
    }
    
    private static func getRating(from vote: Float) -> String {
        return (0..<Int(vote)).reduce("") { (acc, _) -> String in return acc + "⭐️" }
    }
}
