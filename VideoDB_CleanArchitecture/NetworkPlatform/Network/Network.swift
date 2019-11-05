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

public final class Network<T: Decodable> {
    private let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    public init() {
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    deinit {
        print(#line)
    }
    
    public func getMovies(endPoint: Endpoint) -> Observable<[T]> {
        return provider
            .rx
            .request(MultiTarget(VideoDB.movies(endPoint: endPoint)))
            .observeOn(scheduler)
            .map([T].self).asObservable()
    }
}
