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

internal final class Network<T: NetworkRepresentable> where T == T.NetworkType.DomainType {
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
    private func request(_ api: APITarget) -> Observable<T> {
    return Observable<T>.create { (observer) -> Disposable in
            let disposable = self.provider.rx
                .request(MultiTarget(api))
                .observeOn(self.scheduler)
                .asObservable()
                .subscribe(onNext: { (response) in
                    let jsonData = response.data
                    let jsonDecoder = JSONDecoder()
                    
                    /*
                     * Success case:
                     */
                    if var model = try? jsonDecoder.decode(T.NetworkType.self, from: jsonData) {
                        // 1. Add a trigger to know the api type
                        model.responseFromTarget(target: api)
                        // 2
                        observer.onNext(model.asDomain())
                    }
                        
                    /*
                    * Error case:
                    */
                    else {
                        //
                        let jsonString = String(data: jsonData, encoding: .utf8)
                        // 1. API Error
                        if let apiError = try? jsonDecoder.decode(NWResponseError.self, from: jsonData) {
                            let code = apiError.statusCode
                            let description = apiError.statusMessage
                            observer.onError(APIError.apiError(code: code, description: description, info: jsonString))
                        }
                        // 2. Parser Error
                        else {
                            observer.onError(APIError.parserError(description: "Parser Error", info: jsonString))
                        }
                    }
                }, onError: { (error) in
                    observer.onError(APIError.networkError(code: -500))
                })
            return Disposables.create([disposable])
        }
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
