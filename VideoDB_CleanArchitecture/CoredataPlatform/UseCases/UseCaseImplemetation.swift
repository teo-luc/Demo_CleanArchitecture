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
//        let mv = Movie(movieId: 200,
//              posterPath: "posterPath",
//              originalTitle: "originalTitle", overview: "overview", releaseDate: "releaseDate", voteAverage: 0)
//
//        repository.save(entity: mv).asObservable().subscribe(onNext: { (arg0) in
//
//            let () = arg0
//            print("___")
//        })
        let sort = NSSortDescriptor(key: CDMovie.CodingKeys.id.rawValue, ascending: true)
        return repository.query(with: nil, sortDescriptors: [sort])
    }
    
}
