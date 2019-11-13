//
//  NWMoviesResponse.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/13/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation

struct NWMoviesResponse {
    var page         : Int
    var totalResults : Int
    var totalPages   : Int
    var movies       : [NWMovie]
}
