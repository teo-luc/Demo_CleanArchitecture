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
        // 1
        kindOf        = entity[CodingKeys.kindOf] as! Int
        // 2
        let moviesSet = entity[CodingKeys.movies] as! Set<CDMovie.T>
        movies        = moviesSet.map { CDMovie(entity: $0) }
    }
    
    public func update(_ entity: T) {
        // 1
        entity[CodingKeys.kindOf] = kindOf
        // 2
        let movies: Array<CDMovie.T> = self.movies.map { movie in
            let emptyEntity = entity.managedObjectContext?.rx.getOrCreateEntity(for: movie)
            movie.update(emptyEntity!)
            return emptyEntity!
        }
        entity[CodingKeys.movies] = Set(movies)
        // 3
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
