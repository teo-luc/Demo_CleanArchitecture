//
//  Repository.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/11/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import CoreData
import RxCoreData

protocol AbstractRepository {
    associatedtype T
    func query(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Observable<[T]>
    func save(entity: T) -> Observable<Void>
    func delete(entity: T) -> Observable<Void>
}

final class Repository<T: Persistable>: AbstractRepository {
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func query(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Observable<[T]> {
        return context.rx.entities(T.self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    func save(entity: T) -> Observable<Void> {
        return Observable<Void>.create { (observer) -> Disposable in
            do {
                observer.onNext(try self.context.rx.update(entity))
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func delete(entity: T) -> Observable<Void> {
        return Observable<Void>.create { (observer) -> Disposable in
            do {
                observer.onNext(try self.context.rx.delete(entity))
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
