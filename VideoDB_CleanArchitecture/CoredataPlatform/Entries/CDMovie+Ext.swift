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
    struct Person {
      var address: Int
    }
    
    enum CDKeys: String, CodingKey {
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
        return CDMovie.CDKeys.id.rawValue
    }
    
    var identity: String {
        return String(movieId)
    }
    
    public init(entity: T) {
        movieId       = entity[CDKeys.id]            as! Int
        posterPath    = entity[CDKeys.posterPath]    as! String
        originalTitle = entity[CDKeys.originalTitle] as! String
        overview      = entity[CDKeys.overview]      as! String
        releaseDate   = entity[CDKeys.releaseDate]   as! String
        voteAverage   = entity[CDKeys.voteAverage]   as! Float
    }
    
    public func update(_ entity: T) {
        entity[CDKeys.id]            = movieId
        entity[CDKeys.posterPath]    = posterPath
        entity[CDKeys.originalTitle] = originalTitle
        entity[CDKeys.overview]      = overview
        entity[CDKeys.releaseDate]   = releaseDate
        entity[CDKeys.voteAverage]   = voteAverage
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
