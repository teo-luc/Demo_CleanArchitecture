//
//  UseCasesProvider.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/5/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Domain


public final class UseCaseProviderImplemetation: Domain.UseCaseProvider {
    private let networkProvider: NetworkProvider
    public init() {
        networkProvider = NetworkProvider()
    }
    public func makeMovieUseCase() -> Domain.MovieUseCase {
        return UseCaseImplemetation(network: networkProvider.makeMoviesResponseNetwork())
    }
    

}
