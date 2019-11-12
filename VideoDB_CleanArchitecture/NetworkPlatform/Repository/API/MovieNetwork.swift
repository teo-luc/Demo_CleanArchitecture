//
//  MoviesNetwork.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/5/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import Domain

// MARK: MoviesNetworkProtocol

protocol MovieNetworkProtocol {
    func fetchMovie(movieId: String) -> Observable<Movie>
}

// MARK: MoviesNetwork

internal final class MovieNetwork: MovieNetworkProtocol {
    private let network: Network<Movie>
    private let apiKey: String
    init(network: Network<Movie>, apiKey: String) {
        self.network = network
        self.apiKey = apiKey
    }
    
    public func fetchMovie(movieId: String) -> Observable<Movie> {
        return network.getMovie(apiKey: apiKey, movieId: movieId)
    }
}
