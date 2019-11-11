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

extension Movie : IdentifiableType {
    public typealias Identity = String

    public var identity: Identity { return String(movieId) }
}

extension Movie : Persistable {
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
        return "CD_Movie"
    }
    
    public static var primaryAttributeName: String {
        return Movie.CodingKeys.id.rawValue
    }
    
    public init(entity: T) {
        let movieId       = entity.value(forKey : Movie.CodingKeys.id.rawValue)            as! Int
        let posterPath    = entity.value(forKey : Movie.CodingKeys.posterPath.rawValue)    as! String
        let originalTitle = entity.value(forKey : Movie.CodingKeys.originalTitle.rawValue) as! String
        let overview      = entity.value(forKey : Movie.CodingKeys.overview.rawValue)      as! String
        let releaseDate   = entity.value(forKey : Movie.CodingKeys.releaseDate.rawValue)   as! String
        let voteAverage   = entity.value(forKey : Movie.CodingKeys.voteAverage.rawValue)   as! Float
        //
        self.init(movieId       : movieId,
                  posterPath    : posterPath,
                  originalTitle : originalTitle,
                  overview      : overview,
                  releaseDate   : releaseDate,
                  voteAverage   : voteAverage)
    }
    
    public func update(_ entity: T) {
        entity.setValue(movieId,      forKey : Movie.CodingKeys.id.rawValue)
        entity.setValue(posterPath,   forKey : Movie.CodingKeys.posterPath.rawValue)
        entity.setValue(originalTitle,forKey : Movie.CodingKeys.originalTitle.rawValue)
        entity.setValue(overview,     forKey : Movie.CodingKeys.overview.rawValue)
        entity.setValue(releaseDate,  forKey : Movie.CodingKeys.releaseDate.rawValue)
        entity.setValue(voteAverage,  forKey : Movie.CodingKeys.voteAverage.rawValue)
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
}
