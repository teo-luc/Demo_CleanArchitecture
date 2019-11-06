//
//  NetworkProvider.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Domain

internal final class NetworkProvider {
    private let apiEndpoint: String
    private let apiKey: String
    public init() {
        apiEndpoint = BASE_URL
        apiKey      = API_KEY
    }
    
    func makeMoviesResponseNetwork() -> MoviesResponseNetwork {
        let network = Network<MoviesResponse>(endPoint: apiEndpoint)
        return MoviesResponseNetwork(network: network, apiKey: apiKey)
    }
    
    func makeMovieNetwork() -> MovieNetwork {
        let network = Network<Movie>(endPoint: apiEndpoint)
        return MovieNetwork(network: network, apiKey: apiKey)
    }
}
