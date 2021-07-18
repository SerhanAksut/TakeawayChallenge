//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import RxSwift

public extension Observable {
    static func pipe() -> (observer: AnyObserver<Element>, observable: Observable<Element>) {
        let subject = PublishSubject<Element>()
        return (subject.asObserver(), subject.asObservable())
    }

    static func sharedPipe() -> (observer: AnyObserver<Element>, observable: Observable<Element>) {
        let subject = BehaviorSubject(value: nil as Element?)
        let observer = AnyObserver.init { (event: Event<Element>) in
            switch event {
            case .completed:
                subject.onCompleted()
            case .error(let error):
                subject.onError(error)
            case .next(let element):
                subject.onNext(element)
            }
        }
        
        let observable = subject
            .asObservable()
            .compactMap { $0 }
        
        return (observer, observable)
    }
}
