//
//  MovieResponse+Mapping.swift
//  NetworkPlatform
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Domain

extension MoviesResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages   = "total_pages"
        case totalResults = "total_results"
        case movies       = "results"
    }

    public init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: CodingKeys.self)
        //
        let movies       = try container.decode([Movie].self, forKey : .movies)
        let page         = try container.decode(Int.self,     forKey : .page)
        let totalResults = try container.decode(Int.self,     forKey : .totalResults)
        let totalPages   = try container.decode(Int.self,     forKey : .totalPages)
        //
        self.init(page         : page,
                  totalResults : totalResults,
                  totalPages   : totalPages,
                  movies       : movies)
    }

    public func encode(to encoder: Encoder) throws {
        /*Your stuff here!!!**/
    }
}
