//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import Foundation
import RxSwift
import RxCocoa

/**
 Enables monitoring of sequence computation.

 If there is at least one sequence computation in progress, `true` will be sent.
 When all activities complete `false` will be sent.
 */
public class ActivityIndicator: SharedSequenceConvertibleType {
    public typealias Element = Bool
    public typealias SharingStrategy = DriverSharingStrategy

    private let _lock = NSRecursiveLock()
    private let _relay = BehaviorRelay(value: 0)
    private let _loading: SharedSequence<SharingStrategy, Bool>

    public init() {
        _loading = _relay
            .asDriver()
            .map { $0 > 0 }
            .distinctUntilChanged()
    }

    func trackActivityOfObservable<Source: ObservableConvertibleType>(
        _ source: Source
    ) -> Observable<Source.Element> {
        Observable.using { () -> ActivityToken<Source.Element> in
            self.increment()
            return ActivityToken(
                source: source.asObservable(),
                disposeAction: self.decrement
            )
        } observableFactory: { disposable in
            disposable.asObservable()
        }
    }

    private func increment() {
        _lock.lock()
        _relay.accept(_relay.value + 1)
        _lock.unlock()
    }

    private func decrement() {
        _lock.lock()
        _relay.accept(_relay.value - 1)
        _lock.unlock()
    }

    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        _loading
    }
}

public extension ActivityIndicator {
    func withDelay(
        _ time: RxTimeInterval = .milliseconds(400)
    ) -> Driver<Bool> {
        self.asObservable()
            .map { inProgress -> Observable<Bool> in
                if inProgress {
                    return Observable.just(true)
                        .delay(time, scheduler: DriverSharingStrategy.scheduler)
                } else {
                    return Observable.just(false)
                }
            }
            .switchLatest()
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .never())
    }
}
