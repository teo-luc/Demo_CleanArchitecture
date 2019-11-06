//
//  MovieUseCase.swift
//  Domain
//
//  Created by Teqnological on 11/5/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import RxSwift

public protocol MovieUseCase {
    func movies() -> Observable<[Movie]>
}
