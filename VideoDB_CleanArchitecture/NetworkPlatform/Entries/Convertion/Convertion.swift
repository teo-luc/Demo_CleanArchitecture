//
//  Convertion.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/13/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation

// MARK: - CoreData (convert from `Network` -> `Domain`)

protocol DomainConvertibleType {
    associatedtype DomainType
    mutating func responseFromTarget(target: APITarget)
    func asDomain() -> DomainType
}
extension DomainConvertibleType {
    mutating func responseFromTarget(target: APITarget) {
        /* Adding some stuff here */
    }
}

typealias ConvertibleType = Decodable & DomainConvertibleType

// MARK: - Domain (convert from `Domain` -> `Network`)

protocol NetworkRepresentable {
    associatedtype NetworkType: ConvertibleType
    func asNetwork() -> NetworkType
}
