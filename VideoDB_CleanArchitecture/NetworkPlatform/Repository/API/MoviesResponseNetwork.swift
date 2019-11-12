//
//  MovieResponseNetwork.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import Domain

protocol MoviesResponseNetworkProtocol {
    func fetchResponse(kindOf: MoviesResponse.KindOf) -> Observable<MoviesResponse>
}

internal final class MoviesResponseNetwork: MoviesResponseNetworkProtocol {
    private let network: Network<MoviesResponse>
    private let apiKey: String
    init(network: Network<MoviesResponse>, apiKey: String) {
        self.network = network
        self.apiKey = apiKey
    }
    
    func fetchResponse(kindOf: MoviesResponse.KindOf) -> Observable<MoviesResponse> {
        return network.getMovieResponse(apiKey: apiKey, kindOf: kindOf)
    }
}
