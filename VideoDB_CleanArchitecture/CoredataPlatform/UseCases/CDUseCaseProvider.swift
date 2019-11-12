//
//  UseCaseProviderImplemetation.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/11/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Domain

open class CDUseCaseProvider: Domain.UseCaseProvider {
    private let coreDataStack = CoreDataStack()
    private let postRepository: Repository<MoviesResponse>
    public init() {
        postRepository = Repository<MoviesResponse>(context: coreDataStack.context)
    }
    
    public func makeMovieUseCase() -> MovieUseCase {
        return CDMovieUseCase(repository: postRepository)
    }
}
