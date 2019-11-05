//
//  API.swift
//  NetworkPlatform
//
//  Created by Teqnological on 11/5/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import Moya

public enum Endpoint: String {
    case nowPlaying = "now_playing"
    case upcoming
    case popular
    case topRated = "top_rated"
}

public enum VideoDB {
    case movies(endPoint: Endpoint)
    case movieDetail(movieId: String)
}

private let apiKey = "f7b95dac781c846648db2df0f34e314b"

extension VideoDB: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
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
        return .requestParameters(parameters: ["api_key": apiKey], encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
