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

public protocol MoviesNetworkProtocol {
    func fetchMovies(endPoint: Endpoint) -> Observable<[Movie]>
}

// MARK: MoviesNetwork

public final class MoviesNetwork: MoviesNetworkProtocol {
    let network: Network<MoviesResponse>
    
    init(network: Network<MoviesResponse>) {
        self.network = network
    }
    
    public func fetchMovies(endPoint: Endpoint) -> Observable<[Movie]> {
        return self.network.getMovies(endPoint: endPoint).map { $0.movies }
    }
}
