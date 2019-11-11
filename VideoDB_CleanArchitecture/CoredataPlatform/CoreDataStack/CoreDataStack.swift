//
//  CoreDataStack.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/11/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    // MARK: - Private
    private static let _DB = "VideoDB"

    private lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last!
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: CoreDataStack._DB, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator   = NSPersistentStoreCoordinator(managedObjectModel : self.managedObjectModel)
        let url           = self.applicationDocumentsDirectory.appendingPathComponent("\(CoreDataStack._DB).sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict                               = [String : Any]()
            dict[NSLocalizedDescriptionKey]        = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError           = NSError(domain : "YOUR_ERROR_DOMAIN", code : 9999, userInfo : dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator             = self.persistentStoreCoordinator
        var managedObjectContext    = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Public

    var context: NSManagedObjectContext {
        get {
            return self.managedObjectContext
        }
    }
    
    // MARK: - LifeCycle
    
    init() {}
}
