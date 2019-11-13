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
    func asDomain() -> DomainType
}

typealias ConvertibleType = Decodable & DomainConvertibleType

// MARK: - Domain (convert from `Domain` -> `Network`)

protocol NetworkRepresentable {
    associatedtype NetworkType: ConvertibleType
    func asNetwork() -> NetworkType
}
