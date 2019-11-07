//
//  MoviesViewModel.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import Domain

final class MoviesViewModel:  ViewModelType {
    struct Input {
        let kindOf: Driver<Int>
        let pulldown: Driver<Bool>
    }
    
    struct Output {
        let movieItems: Driver<[MovieItemViewModel]>
    }
    
    private let useCase: MovieUseCase
    init(useCase: MovieUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: MoviesViewModel.Input) -> MoviesViewModel.Output {
        let movieItems = input.kindOf.flatMapLatest {
            self.useCase.movies(kindOf: MoviesResponse.KindOf(index: $0)!)
                .asDriver(onErrorJustReturn: [])
                .map { $0.map { MovieItemViewModel(movie: $0) } }
        }
//        let movieItems = Driver<Any>.zip(input.kindOf, input.pulldown)
//            .map {
//                self.useCase.movies(kindOf: MoviesResponse.KindOf(index: $0.0)!)
//                .asDriver(onErrorJustReturn: [])
//                    .map { $0.map { MovieItemViewModel(movie: $0) } }
//        }

        return Output(movieItems: movieItems)
    }
}
