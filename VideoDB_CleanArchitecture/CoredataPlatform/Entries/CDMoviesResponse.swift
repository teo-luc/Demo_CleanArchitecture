//
//  MoviesResponse+CoreData.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/11/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Domain

struct CDMoviesResponse {
    public let kindOf: Int
    public let movies: [CDMovie]
}
