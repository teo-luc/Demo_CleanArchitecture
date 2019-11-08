//
//  ErrorTracker.swift
//  VideoDB_CleanArchitecture
//
//  Created by Teqnological on 11/7/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import RxSwift
import RxCocoa

public final class ErrorTracker: ObservableConvertibleType {
    private let subject =  PublishSubject<Error>()
    public typealias E = Error
    public func asObservable() -> Observable<Error> {
        return subject.asObserver()
    }
    
    func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.E> {
        return source.asObservable().do(onError: onError)
    }
    
    private func onError(_ error: Error) {
        subject.onNext(error)
    }
    
    deinit {
        subject.onCompleted()
    }
}

extension ObservableConvertibleType {
    func trackError(_ errorTracker: ErrorTracker) -> Observable<E> {
        return errorTracker.trackError(from: self)
    }
}
