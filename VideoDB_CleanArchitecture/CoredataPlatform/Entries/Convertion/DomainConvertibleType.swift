//
//  DomainConvertibleType.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/11/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData

protocol DomainConvertibleType {
    associatedtype DomainType
    func asDomain() -> DomainType
}

protocol CoreDataRepresentable {
    associatedtype CoreDataType: Persistable
}

