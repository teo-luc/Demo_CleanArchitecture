//
//  UseCaseImplemetation.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/11/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Domain
import RxSwift

internal class UseCaseImplemetation<Repository>: Domain.MovieUseCase where Repository: AbstractRepository, Repository.T == Movie {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func movies(kindOf: MoviesResponse.KindOf) -> Observable<[Movie]> {
        let movie = Movie.init(movieId: 100,
                   posterPath: "posterPath",
                   originalTitle: "originalTitle",
                   overview: "overview",
                   releaseDate: "2019-10-21",
                   voteAverage: 8.1)
//        self.repository.save(entity: movie).subscribe(onNext: { _ in
//            print("Save Done")
//        })
        
        let sort = NSSortDescriptor(key: Movie.CodingKeys.id.rawValue, ascending: true)
        return repository.query(with: nil, sortDescriptors: [sort])
    }
    
}
