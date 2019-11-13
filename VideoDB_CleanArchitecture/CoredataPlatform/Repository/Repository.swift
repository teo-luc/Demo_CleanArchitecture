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
    func query(with predicate: NSPredicate?) -> Observable<T?>
    func save(entity: T) -> Observable<Void>
    func delete(entity: T) -> Observable<Void>
}

final class Repository<T: CoreDataRepresentable>: AbstractRepository where T == T.CoreDataType.DomainType  {
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func query(with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Observable<[T]> {
        return context.rx.entities(T.CoreDataType.self, predicate: predicate, sortDescriptors: sortDescriptors)
                .map { $0.map { $0.asDomain() } }
    }
    
    func query(with predicate: NSPredicate?) -> Observable<T?> {
        let ob = query(with: predicate, sortDescriptors: nil)
        return ob.map { $0.first }
    }
    
    func save(entity: T) -> Observable<Void> {
        return Observable<Void>.create { (observer) -> Disposable in
            do {
                observer.onNext(try self.context.rx.update(entity.asCoreData()))
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func delete(entity: T) -> Observable<Void> {
        return Observable<Void>.create { (observer) -> Disposable in
            do {
                observer.onNext(try self.context.rx.delete(entity.asCoreData()))
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
