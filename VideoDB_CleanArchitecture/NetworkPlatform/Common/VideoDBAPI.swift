//
//  API.swift
//  NetworkPlatform
//
//  Created by Teqnological on 11/5/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Moya

// MARK: APIs

public enum VideoDBAPI {
    case movies(endPoint: Endpoint)
    case movieDetail(movieId: String)
}

// MARK: ---

extension VideoDBAPI: TargetType {
    public var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    public var path: String {
        var path = ""
        switch self {
        case .movies(let endPoint):
            path = "/movie/\(endPoint.rawValue)"
        case .movieDetail(let movieId):
            path = "/movie/\(movieId)"
        }
        return path
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return
        """
        {
        "string": "Hello World"
        }
        """
        .data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        return .requestParameters(parameters: ["api_key": API_KEY], encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
}

// MARK: --

public enum Endpoint: String {
    case nowPlaying = "now_playing"
    case upcoming
    case popular
    case topRated   = "top_rated"
}
