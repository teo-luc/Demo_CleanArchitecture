//
//  CD_Movie+Ext.swift
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

extension CDMovie : Persistable {
    enum CodingKeys: String, CodingKey {
        case id            = "movieId"
        case posterPath    = "posterPath"
        case originalTitle = "originalTitle"
        case overview      = "overview"
        case releaseDate   = "releaseDate"
        case voteAverage   = "voteAverage"
    }
    
    public typealias T = NSManagedObject
    
    public static var entityName: String {
        return String(describing: self)
    }
    
    public static var primaryAttributeName: String {
        return CDMovie.CodingKeys.id.rawValue
    }
    
    var identity: String {
        return String(movieId)
    }
    
    public init(entity: T) {
        movieId       = entity.value(forKey : CDMovie.CodingKeys.id.rawValue)            as! Int
        posterPath    = entity.value(forKey : CDMovie.CodingKeys.posterPath.rawValue)    as! String
        originalTitle = entity.value(forKey : CDMovie.CodingKeys.originalTitle.rawValue) as! String
        overview      = entity.value(forKey : CDMovie.CodingKeys.overview.rawValue)      as! String
        releaseDate   = entity.value(forKey : CDMovie.CodingKeys.releaseDate.rawValue)   as! String
        voteAverage   = entity.value(forKey : CDMovie.CodingKeys.voteAverage.rawValue)   as! Float
    }
    
    public func update(_ entity: T) {
        entity.setValue(movieId,      forKey : CDMovie.CodingKeys.id.rawValue)
        entity.setValue(posterPath,   forKey : CDMovie.CodingKeys.posterPath.rawValue)
        entity.setValue(originalTitle,forKey : CDMovie.CodingKeys.originalTitle.rawValue)
        entity.setValue(overview,     forKey : CDMovie.CodingKeys.overview.rawValue)
        entity.setValue(releaseDate,  forKey : CDMovie.CodingKeys.releaseDate.rawValue)
        entity.setValue(voteAverage,  forKey : CDMovie.CodingKeys.voteAverage.rawValue)
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
}


extension CDMovie: DomainConvertibleType {
    typealias DomainType = Domain.Movie
    func asDomain() -> DomainType {
        return Movie(movieId       : movieId,
                     posterPath    : posterPath,
                     originalTitle : originalTitle,
                     overview      : overview,
                     releaseDate   : releaseDate,
                     voteAverage   : voteAverage)
    }
}

// Mark: - Domain Extension

extension Movie: CoreDataRepresentable {
    typealias CoreDataType = CDMovie
    func asCoreData() -> CoreDataType {
        return CDMovie(movieId       : movieId,
                       posterPath    : posterPath,
                       originalTitle : originalTitle,
                       overview      : overview,
                       releaseDate   : releaseDate,
                       voteAverage   : voteAverage)
    }
}
