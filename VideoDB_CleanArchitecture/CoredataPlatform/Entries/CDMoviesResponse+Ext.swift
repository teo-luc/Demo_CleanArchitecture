//
//  Movies+Persistable.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/11/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData
import Domain

extension CDMoviesResponse : IdentifiableType {
    public typealias Identity = String

    public var identity: Identity { return String(self.kindOf) }
}

extension CDMoviesResponse: Persistable {
    enum CodingKeys: String, CodingKey {
        case kindOf = "kindOf"
        case movies = "movies"
    }
    
    public typealias T = NSManagedObject

    public static var entityName: String {
        return "CDMoviesResponse"
    }
    
    public static var primaryAttributeName: String {
        return CDMoviesResponse.CodingKeys.kindOf.rawValue
    }
    
    public init(entity: T) {
        kindOf = entity.value(forKey: CDMoviesResponse.CodingKeys.kindOf.rawValue) as! Int
        movies = entity.value(forKey: CDMoviesResponse.CodingKeys.movies.rawValue) as! [CDMovie]
    }
    
    public func update(_ entity: T) {
        entity.setValue(kindOf, forKey : CDMoviesResponse.CodingKeys.kindOf.rawValue)
        entity.setValue(movies, forKey : CDMoviesResponse.CodingKeys.movies.rawValue)
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
}

