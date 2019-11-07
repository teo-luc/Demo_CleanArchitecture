//
//  Movie+Mapping.swift
//  NetworkPlatform
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Domain

extension Movie : Codable {
    //
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath    = "poster_path"
        case originalTitle = "original_title"
        case overview
        case releaseDate   = "release_date"
        case voteAverage   = "vote_average"
    }
    //
    public init(from decoder: Decoder) throws {
        let container     = try decoder.container(keyedBy: CodingKeys.self)
        //
        let movieId       = try container.decode(Int.self,    forKey : .id)
        let posterPath    = try container.decode(String.self, forKey : .posterPath)
        let originalTitle = try container.decode(String.self, forKey : .originalTitle)
        let overview      = try container.decode(String.self, forKey : .overview)
        let releaseDate   = try container.decode(String.self, forKey : .releaseDate)
        let voteAverage   = try container.decode(Float.self,  forKey : .voteAverage)
        //
        self.init(movieId       : movieId,
                  posterPath    : posterPath,
                  originalTitle : originalTitle,
                  overview      : overview,
                  releaseDate   : releaseDate,
                  voteAverage   : voteAverage)
    }
    
    public func encode(to encoder: Encoder) throws {
        /*Your stuff here!!!**/
    }
}
