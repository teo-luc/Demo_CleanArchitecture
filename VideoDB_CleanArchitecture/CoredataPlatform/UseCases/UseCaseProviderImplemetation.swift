//
//  UseCaseProviderImplemetation.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/11/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Domain

open class UseCaseProviderImplemetation: Domain.UseCaseProvider {
    private let coreDataStack = CoreDataStack()
    private let postRepository: Repository<Movie>
    public init() {
        postRepository = Repository<Movie>(context: coreDataStack.context)
    }
    
    public func makeMovieUseCase() -> MovieUseCase {
        return UseCaseImplemetation(repository: postRepository)
    }
}
