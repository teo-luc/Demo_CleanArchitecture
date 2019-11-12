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
        let movies = MoviesResponse(page: 0, totalResults: 0, totalPages: 0, movies: [
            Movie(movieId: 1, posterPath: "posterPath", originalTitle: "originalTitle", overview: "overview", releaseDate: "releaseDate", voteAverage: 1),
            Movie(movieId: 1, posterPath: "posterPath", originalTitle: "originalTitle", overview: "overview", releaseDate: "releaseDate", voteAverage: 2)
        ])
        
        repository.save(entity: movies).subscribe(onNext: { _ in
            print("---")
        })
        
        
        return repository.query(with: nil, sortDescriptors: nil)
            .map { array -> [Movie] in
                var movies = [Movie]()
                array.forEach { (MoviesResponse) in
                    movies.append(contentsOf: MoviesResponse.movies)
                }
                return movies
        }
    }
}
