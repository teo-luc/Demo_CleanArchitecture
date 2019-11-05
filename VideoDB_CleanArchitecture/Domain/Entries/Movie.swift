//
//  Movie.swift
//  Domain
//
//  Created by Teqnological on 11/5/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation

// MARK: - Movie

public struct Movie: Codable {
    let id: Int
    let posterPath: String
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let voteAverage: Float
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath    = "poster_path"
        case originalTitle = "original_title"
        case overview
        case releaseDate   = "release_date"
        case voteAverage   = "vote_average"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id            = try container.decode(Int.self, forKey: .id)
        posterPath    = try container.decode(String.self, forKey: .posterPath)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        overview      = try container.decode(String.self, forKey: .overview)
        releaseDate   = try container.decode(String.self, forKey: .releaseDate)
        voteAverage   = try container.decode(Float.self, forKey: .voteAverage)
    }
}

extension Movie: Equatable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return (
            lhs.id                  == rhs.id            &&
                lhs.posterPath      == rhs.posterPath    &&
                lhs.originalTitle   == rhs.originalTitle &&
                lhs.overview        == rhs.overview      &&
                lhs.releaseDate     == rhs.releaseDate   &&
                lhs.voteAverage     == rhs.voteAverage
        )
    }
}


// MARK: - MoviesResponse

public struct MovieResponse : Codable {
    let movies: [Movie]
    
}

