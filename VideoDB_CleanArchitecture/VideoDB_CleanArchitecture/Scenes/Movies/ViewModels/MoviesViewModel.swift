//
//  MoviesViewModel.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/6/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

final class MoviesViewModel:  ViewModelType {
    // 1. Input
    struct Input {
        let trigger: Driver<Int>
    }
    
    // 2. Output
    struct Output {
        let fetching: Driver<Bool>
        let error: Driver<Error>
        let movieItems: Driver<[MovieItemViewModel]>
    }
    
    // MARK: LifeCycle
    
    private let useCase: MovieUseCase
    init(useCase: MovieUseCase) {
        self.useCase = useCase
    }
    
    // 3
    func transform(input: MoviesViewModel.Input) -> MoviesViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let trackError = ErrorTracker()
        let movieItems =
            input.trigger
                .throttle(0.05)
                .flatMapLatest {
                    self.useCase
                        .movies(kindOf: MoviesResponse.KindOf(index: $0)!)
                        .trackActivity(activityIndicator)
                        .trackError(trackError)
                        .asDriverOnErrorJustComplete()
                        .map { $0.map { MovieItemViewModel(movie: $0) } }
                }
        return Output(fetching   : activityIndicator.asObservable().asDriverOnErrorJustComplete(),
                      error      : trackError.asObservable().asDriverOnErrorJustComplete(),
                      movieItems : movieItems)
    }
}
