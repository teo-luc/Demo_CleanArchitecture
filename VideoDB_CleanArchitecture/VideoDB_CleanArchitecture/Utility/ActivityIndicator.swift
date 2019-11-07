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
    public func asObservable() -> Observable<Bool> {
        return behavior.asObservable().distinctUntilChanged()
    }
    
    public func trackActivity<T: ObservableType>(from observable: T) -> Observable<T.E> {
        return observable.do(onNext: { _ in
            self.setStatus(false)
        }, onError: { error in
            self.setStatus(false)
        }, onCompleted: {
            self.setStatus(false)
        }, onSubscribe: {
            self.setStatus(true)
        })
    }
    
    private func setStatus(_ isLoading: Bool) {
        behavior.accept(isLoading)
    }
}


extension ObservableType {
    public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<E> {
        return activityIndicator.trackActivity(from: self)
    }
}
