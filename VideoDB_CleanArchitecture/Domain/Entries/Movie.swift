//
//  Movie.swift
//  Domain
//
//  Created by Teqnological on 11/5/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation

// MARK: - Movie

public struct Movie {
    //
    public let movieId       : Int
    public let posterPath    : String
    public let originalTitle : String
    public let overview      : String
    public let releaseDate   : String
    public let voteAverage   : Float
    
    public init(movieId       : Int,
                posterPath    : String,
                originalTitle : String,
                overview      : String,
                releaseDate   : String,
                voteAverage   : Float) {
        self.movieId       = movieId
        self.posterPath    = posterPath
        self.originalTitle = originalTitle
        self.overview      = overview
        self.releaseDate   = releaseDate
        self.voteAverage   = voteAverage
    }
}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return (
                lhs.movieId         == rhs.movieId       &&
                lhs.posterPath      == rhs.posterPath    &&
                lhs.originalTitle   == rhs.originalTitle &&
                lhs.overview        == rhs.overview      &&
                lhs.releaseDate     == rhs.releaseDate   &&
                lhs.voteAverage     == rhs.voteAverage
        )
    }
}

