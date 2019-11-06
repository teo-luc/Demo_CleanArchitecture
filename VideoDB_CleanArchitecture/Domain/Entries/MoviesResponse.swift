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
    public let page         : Int
    public let totalResults : Int
    public let totalPages   : Int
    public let movies       : [Movie]
    
    public init(page: Int, totalResults :Int, totalPages: Int, movies: [Movie]) {
        self.page         = page
        self.totalPages   = totalPages
        self.totalResults = totalResults
        self.movies       = movies
    }
}


extension MoviesResponse: Equatable {
    public static func == (lhs: MoviesResponse, rhs: MoviesResponse) -> Bool {
        return (
            lhs.movies       == rhs.movies       &&
            lhs.page         == rhs.page         &&
            lhs.totalResults == rhs.totalResults &&
            lhs.totalPages   == rhs.totalPages)
    }
}
