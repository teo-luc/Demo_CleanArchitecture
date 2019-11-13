//
//  NWMoviesResponse+Mapping.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/13/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Domain

extension NWMoviesResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages   = "total_pages"
        case totalResults = "total_results"
        case movies       = "results"
    }

    public init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: CodingKeys.self)
        //
        movies       = try container.decode([NWMovie].self, forKey : .movies)
        page         = try container.decode(Int.self,       forKey : .page)
        totalResults = try container.decode(Int.self,       forKey : .totalResults)
        totalPages   = try container.decode(Int.self,       forKey : .totalPages)
        //
    }

    public func encode(to encoder: Encoder) throws {
        /*Your stuff here!!!**/
    }
}

extension NWMoviesResponse: DomainConvertibleType {
    typealias DomainType = Domain.MoviesResponse
    func asDomain() -> DomainType {
        return DomainType(page         : page,
                          totalResults : totalResults,
                          totalPages   : totalPages,
                          movies       : self.movies.map { $0.asDomain() } )
    }
}

extension Domain.MoviesResponse: NetworkRepresentable {
    typealias NetworkType = NWMoviesResponse
    func asNetwork() -> NWMoviesResponse {
        return NWMoviesResponse(page         : page,
                                totalResults : totalResults,
                                totalPages   : totalPages,
                                movies       : movies.map { $0.asNetwork() })
    }
}
