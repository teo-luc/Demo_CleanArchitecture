//
//  DomainConvertibleType.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/11/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import CoreData
import RxDataSources
import RxCoreData

// MARK: - CoreData (convert from `CoreData` -> `Domain`)

protocol DomainConvertibleType {
    associatedtype DomainType
    func asDomain() -> DomainType
}

typealias CoreDataConvertibleType = Persistable & DomainConvertibleType

// MARK: - Domain (convert from `Domain` -> `CoreData`)

protocol CoreDataRepresentable {
    associatedtype CoreDataType: CoreDataConvertibleType
    func asCoreData() -> CoreDataType
}
