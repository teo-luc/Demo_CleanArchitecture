//
//  Network.swift
//  NetworkPlatform
//
//  Created by Teqnological on 11/5/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Domain

// MARK: Network

internal final class Network<T: Decodable> {
    private let endPoint: String
    //
    private let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private let scheduler: ConcurrentDispatchQueueScheduler
    //
    public init(endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background,
                                                                           relativePriority: 1))
    }
    
    public func getMovieResponse(apiKey: String, kindOf: MoviesResponse.KindOf) -> Observable<T> {
        return request(.movies(url: endPoint, key: apiKey, type: kindOf))
    }
    
    public func getMovie(apiKey: String, movieId: String) -> Observable<T> {
        return request(.movieDetail(url: endPoint, key: apiKey, movieId: movieId))
    }
}

// MARK: Network Extension

extension Network {
    private func request<Type: Decodable>(_ api: APIs) -> Observable<Type> {
        return provider
                .rx
                .request(MultiTarget(api))
                .observeOn(scheduler)
                .asObservable().map(Type.self)

    }
}
