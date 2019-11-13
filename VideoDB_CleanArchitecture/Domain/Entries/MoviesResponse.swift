//
//  MoviesResponse.swift
//  Domain
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation

// MARK: - MoviesResponse

public struct MoviesResponse {
    public let type         : KindOf
    public let movies       : [Movie]
    public init(type: KindOf, movies: [Movie]) {
        self.type   = type
        self.movies = movies
    }
}


extension MoviesResponse: Equatable {
    public static func == (lhs: MoviesResponse, rhs: MoviesResponse) -> Bool {
        return (
            lhs.type    == rhs.type &&
            lhs.movies  == rhs.movies)
    }
}

// MARK: - MoviesResponse Extension

public extension MoviesResponse {
    enum KindOf: String {
        case nowPlaying = "now_playing"
        case upcoming
        case popular
        case topRated   = "top_rated"
        
        public init?(index: Int) {
            switch index {
            case 0: self = .nowPlaying
            case 1: self = .popular
            case 2: self = .upcoming
            case 3: self = .topRated
            default: return nil
            }
        }
    }
}
