//
//  ResponseError.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/7/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation

struct ResponseError: Codable {
    
    public let statusCode    : Int
    public let statusMessage : String
    public let success       : Bool
    
    private enum CodingKeys : String, CodingKey {
        case statusCode    = "status_code"
        case statusMessage = "status_message"
        case success
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //
        statusCode    = try container.decode(Int.self,    forKey: .statusCode)
        statusMessage = try container.decode(String.self, forKey: .statusMessage)
        success       = try container.decode(Bool.self,   forKey: .success)
        //
    }

    public func encode(to encoder: Encoder) throws {
        /*Your stuff here!!!**/
    }
}
