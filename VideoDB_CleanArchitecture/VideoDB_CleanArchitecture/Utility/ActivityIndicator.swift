//
//  ActivityIndicator.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/7/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import RxSwift
import RxCocoa

public final class ActivityIndicator: ObservableConvertibleType {
    public typealias E = Bool
    private let behavior = BehaviorRelay<Bool>(value: false)
    private let lock = NSRecursiveLock()
    public func asObservable() -> Observable<Bool> {
        return behavior.asObservable().distinctUntilChanged()
    }
    
    public func trackActivity<T: ObservableType>(from observable: T) -> Observable<T.E> {
        return observable.do(onNext: { _ in
            self.sendStopLoading()
        }, onError: { error in
            self.sendStopLoading()
        }, onCompleted: {
            self.sendStopLoading()
        }, onSubscribe: subscribed)
    }
    
    private func subscribed() {
        lock.lock()
        behavior.accept(true)
        lock.unlock()
    }
    
    private func sendStopLoading() {
        lock.lock()
        behavior.accept(false)
        lock.unlock()
    }
}


extension ObservableType {
    public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<E> {
        return activityIndicator.trackActivity(from: self)
    }
}
