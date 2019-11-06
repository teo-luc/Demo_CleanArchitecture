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
    case movies     (url: String, key: String, type: MoviesResponse.KindOf)
    case movieDetail(url: String, key: String, movieId: String)
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
        var path = ""
        switch self {
        case .movies(_, _, let type):
            path = "/movie/\(type.rawValue)"
        case .movieDetail(_, _, let movieId):
            path = "/movie/\(movieId)"
        }
        return path
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
