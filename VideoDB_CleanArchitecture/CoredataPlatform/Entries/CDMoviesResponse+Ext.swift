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


// Mark: - CoreData Extension

extension CDMoviesResponse: Persistable {
    enum CodingKeys: String, CodingKey {
        case kindOf = "kindOf"
        case movies = "movies"
    }
    
    public typealias T = NSManagedObject

    public static var entityName: String {
        return "CDMovies"
    }
    
    public static var primaryAttributeName: String {
        return CodingKeys.kindOf.rawValue
    }

    public var identity: String {
        return String(self.kindOf)
    }

    public init(entity: T) {
        kindOf = entity[CodingKeys.kindOf] as! Int
        movies = entity[CodingKeys.movies] as! [CDMovie]
    }
    
    public func update(_ entity: T) {
        Set(movies)
        entity[CodingKeys.kindOf] = kindOf
        entity[CodingKeys.movies] = movies
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
}

extension CDMoviesResponse: DomainConvertibleType {
    typealias DomainType = Domain.MoviesResponse
    func asDomain() -> DomainType {
        return DomainType(page: 0, totalResults: 0, totalPages: 0, movies: self.movies.map { $0.asDomain() })
    }
}

// Mark: - Domain Extension

extension MoviesResponse: CoreDataRepresentable {
    typealias CoreDataType = CDMoviesResponse
    func asCoreData() -> CoreDataType {
        return CoreDataType(kindOf: 1, movies: self.movies.map { $0.asCoreData() })
    }
}
