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

extension MoviesResponse : IdentifiableType {
    public typealias Identity = String

    public var identity: Identity { return String(self.page) }
}

extension MoviesResponse: Persistable {
    enum CodingKeys: String, CodingKey {
        case page         = "page"
        case totalPages   = "totalPages"
        case totalResults = "totalResults"
        case movies       = "movies"
    }
    
    public typealias T = NSManagedObject

    public static var entityName: String {
        return "CD_Movies"
    }
    
    public static var primaryAttributeName: String {
        return MoviesResponse.CodingKeys.page.rawValue
    }
    
    public init(entity: T) {
        let page         = entity.value(forKey: MoviesResponse.CodingKeys.page.rawValue)         as! Int
        let totalPages   = entity.value(forKey: MoviesResponse.CodingKeys.totalPages.rawValue)   as! Int
        let totalResults = entity.value(forKey: MoviesResponse.CodingKeys.totalResults.rawValue) as! Int
        let movies       = entity.value(forKey: MoviesResponse.CodingKeys.movies.rawValue)       as! [Movie]
        //
        self.init(page         : page,
                  totalResults : totalResults,
                  totalPages   : totalPages,
                  movies       : movies)
    }
    
    public func update(_ entity: T) {
        entity.setValue(page,        forKey : MoviesResponse.CodingKeys.page.rawValue)
        entity.setValue(totalPages,  forKey : MoviesResponse.CodingKeys.totalPages.rawValue)
        entity.setValue(totalResults,forKey : MoviesResponse.CodingKeys.totalResults.rawValue)
        entity.setValue(movies,      forKey : MoviesResponse.CodingKeys.movies.rawValue)
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
}

