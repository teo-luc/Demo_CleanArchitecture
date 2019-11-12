//
//  Error.swift
//  NetworkPlatform
//
//  Created by Teqnological on 11/8/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation

internal enum APIError: Error {
    case apiError       (code: Int, description: String, info: String?)
    case networkError   (code: Int)
    case parserError    (description: String, info: String?)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .apiError(_, let description, _):
            return description
        case .parserError(let description, _):
            return description
        case .networkError(_):
            return "Network Error"
        }
    }
    
    var errorCode: Int? {
        switch self {
        case .apiError(let code, _, _):
            return code
        case .parserError:
            return -1
        case .networkError(let code):
            return code
        }
    }
}
