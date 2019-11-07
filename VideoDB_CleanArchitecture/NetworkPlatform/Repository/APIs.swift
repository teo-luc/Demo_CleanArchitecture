//
//  API.swift
//  NetworkPlatform
//
//  Created by Teqnological on 11/5/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Moya
import Domain

// MARK: APIs

internal enum APIs {
    case movies     (url: String, key: String, kindOf: String)
    case movieDetail(url: String, key: String, movieId: String)
}

internal enum APIError: Error {
    case networkError (description: String, moreInfo: Error)
    case authenticationError (description: String)
    case parserError (description: Data)
}

// MARK: APIs Extension

extension APIs: TargetType {
    public var baseURL: URL {
        switch self {
        case .movies     (let baseURL, _, _),
             .movieDetail(let baseURL, _, _):
            return URL(string: baseURL)!
        }
    }
    
    public var path: String {
        switch self {
        case .movies(_, _, let kindOf):
            return "/movie/\(kindOf)"
        case .movieDetail(_, _, let movieId):
            return "/movie/\(movieId)"
        }
    }
    
    public var method: Moya.Method { return .get }
    
    public var sampleData: Data { return "[{}]".data(using: String.Encoding.utf8)! }
    
    public var task: Task {
        switch self {
        case .movies     (_, let key, _),
             .movieDetail(_, let key, _):
            return .requestParameters(parameters: ["api_key": key], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? { return nil }
}
