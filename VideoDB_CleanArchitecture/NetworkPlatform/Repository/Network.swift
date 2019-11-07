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

// MARK: - Network

internal final class Network<T: Decodable> {
    private let endPoint: String
    //
    private let provider = IgnoringCacheDataProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private let scheduler: ConcurrentDispatchQueueScheduler
    //
    public init(endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(
            qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority : 1)
        )
    }
    
    public func getMovieResponse(apiKey: String, kindOf: MoviesResponse.KindOf) -> Observable<T> {
        return request(.movies(url    : endPoint,
                               key    : apiKey,
                               kindOf : kindOf.rawValue))
    }
    
    public func getMovie(apiKey: String, movieId: String) -> Observable<T> {
        return request(.movieDetail(url     : endPoint,
                                    key     : apiKey,
                                    movieId : movieId))
    }
}

// MARK: Network Extension

extension Network {
    private func request<Type: Decodable>(_ api: APIs) -> Observable<Type> {
    return Observable<Type>.create { (observer) -> Disposable in
            let disposable = self.provider.rx
                .request(MultiTarget(api))
                .observeOn(self.scheduler)
                .asObservable()
                .subscribe(onNext: { (response) in
//                    let statusCode = response.statusCode
                    let jsonData = response.data
                    let jsonDecoder = JSONDecoder()
                    if let model = try? jsonDecoder.decode(Type.self, from: jsonData) {
                        observer.onNext(model)
                    } else {
                        if let responseError = try? jsonDecoder.decode(ResponseError.self, from: jsonData) {
                            observer.onError(APIError.authenticationError(description: responseError.statusMessage))
                        } else {
                            observer.onError(APIError.parserError(description: jsonData))
                        }
                    }
                }, onError: { (error) in
                    observer.onError(APIError.networkError(description: "Network Error",moreInfo: error))
                })
            return Disposables.create([disposable])
        }
//        return provider.rx
//            .request(MultiTarget(api))
//            .observeOn(scheduler)
//            .asObservable().map(Type.self)
    }
}

// MARK: - Custom MoyaProvider

fileprivate final class IgnoringCacheDataProvider<Target: TargetType>: MoyaProvider<Target> {
    init(
        endpointClosure : @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
        requestClosure  : @escaping RequestClosure  = MoyaProvider<Target>.defaultRequestMapping,
        stubClosure     : @escaping StubClosure     = MoyaProvider.neverStub,
        manager         : Manager                   = MoyaProvider<Target>.defaultAlamofireManager(),
        plugins         : [PluginType]              = [],
        trackInflights  : Bool                      = false) {
        super.init(
            endpointClosure : endpointClosure,
            requestClosure  : { endpoint, closure in
                var request         = try! endpoint.urlRequest()
                // Ignoring the cache data
                request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
                closure(.success(request))
            },
            stubClosure     : stubClosure,
            manager         : manager,
            plugins         : plugins,
            trackInflights  : trackInflights
        )
    }
}
