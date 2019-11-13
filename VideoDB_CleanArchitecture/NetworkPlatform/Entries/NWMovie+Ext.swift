//
//  NWMovie+Mapping.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/13/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Domain

extension NWMovie: Codable {
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
        movieId       = try container.decode(Int.self,    forKey : .id)
        posterPath    = try container.decode(String.self, forKey : .posterPath)
        originalTitle = try container.decode(String.self, forKey : .originalTitle)
        overview      = try container.decode(String.self, forKey : .overview)
        releaseDate   = try container.decode(String.self, forKey : .releaseDate)
        voteAverage   = try container.decode(Float.self,  forKey : .voteAverage)
    }
    
    public func encode(to encoder: Encoder) throws {
        /*Your stuff here!!!**/
    }
}

extension NWMovie: DomainConvertibleType {
    typealias DomainType = Domain.Movie
    func asDomain() -> DomainType {
        return DomainType(movieId       : movieId,
                          posterPath    : posterPath,
                          originalTitle : originalTitle,
                          overview      : overview,
                          releaseDate   : releaseDate,
                          voteAverage   : voteAverage)
    }    
}

extension Domain.Movie: NetworkRepresentable {
    typealias NetworkType = NWMovie
    func asNetwork() -> NetworkType {
        return NetworkType(movieId       : movieId,
                           posterPath    : posterPath,
                           originalTitle : originalTitle,
                           overview      : overview,
                           releaseDate   : releaseDate,
                           voteAverage   : voteAverage)
    }
}
