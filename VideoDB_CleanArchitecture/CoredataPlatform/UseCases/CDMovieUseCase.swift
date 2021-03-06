//
//  UseCaseImplemetation.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/11/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Domain
import RxSwift

internal class CDMovieUseCase<Repository>: Domain.MovieUseCase
                                           where Repository: AbstractRepository,
                                                 Repository.T == MoviesResponse {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func movies(kindOf: MoviesResponse.KindOf) -> Observable<[Movie]> {
        return repository.query(with: nil).map { (moviesResponse) in
            return moviesResponse?.movies ?? []
        }
    }
}
