//
//  MovieUseCase.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import Domain


internal class UseCaseImplemetation: Domain.MovieUseCase {
    private let network: MoviesResponseNetwork
    init(network: MoviesResponseNetwork /*, cache: Cache*/) {
        self.network = network
    }
    func movies() -> Observable<[Movie]> {
        return network.fetchResponse(endPoint: .nowPlaying).map { $0.movies }
    }
    
    
}
