//
//  MoviesResponse.swift
//  Domain
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation

// MARK: - MoviesResponse

public struct MoviesResponse : Codable {
    public let page         : Int
    public let totalResults : Int
    public let totalPages    : Int
    public let movies       : [Movie]

    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages   = "total_pages"
        case totalResults = "total_results"
        case movies       = "results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movies        = try container.decode([Movie].self, forKey: .movies)
        page          = try container.decode(Int.self, forKey: .page)
        totalResults  = try container.decode(Int.self, forKey: .totalResults)
        totalPages    = try container.decode(Int.self, forKey: .totalPages)
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}


extension MoviesResponse: Equatable {
    public static func == (lhs: MoviesResponse, rhs: MoviesResponse) -> Bool {
        return (
            lhs.movies      == rhs.movies       &&
            lhs.page        == rhs.page         &&
            lhs.totalResults == rhs.totalResults &&
            lhs.totalPages  == rhs.totalPages)
    }
}
