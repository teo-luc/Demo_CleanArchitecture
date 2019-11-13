//
//  NWMoviesResponse.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/13/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Domain
struct NWMoviesResponse {
    var type         : MoviesResponse.KindOf?
    var page         : Int
    var totalResults : Int
    var totalPages   : Int
    var movies       : [NWMovie]
}
