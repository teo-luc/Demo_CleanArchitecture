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
        let trigger: Driver<Int>
    }
    
    struct Output {
        let movieItems: Driver<[MovieItemViewModel]>
    }
    
    private let useCase: MovieUseCase
    init(useCase: MovieUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: MoviesViewModel.Input) -> MoviesViewModel.Output {
        let movieItems =
            input.trigger
                .throttle(0.05)
                .flatMapLatest {
                    self.useCase
                        .movies(kindOf: MoviesResponse.KindOf(index: $0)!)
                        .asDriverOnErrorJustComplete()
                        .map { $0.map { MovieItemViewModel(movie: $0) } }
                }
        return Output(movieItems: movieItems)
    }
}
