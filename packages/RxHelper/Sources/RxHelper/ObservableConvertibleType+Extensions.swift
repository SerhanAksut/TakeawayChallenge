//
//  File.swift
//  
//
//  Created by Serhan Aksut on 18.07.2021.
//

import RxSwift
import RxCocoa

/// Returns a tuple value that contains(elements, errors) after materializing api call response.
public extension ObservableConvertibleType {
    func apiCall<Target>(
            _ activityIndicator: ActivityIndicator? = nil,
            call: @escaping (Element) -> Target
        ) -> (Driver<Target.Element>, Driver<Error>) where Target: ObservableConvertibleType {
        
        let stream = self.asObservable()
            .flatMapLatest { element -> Observable<Event<Target.Element>> in
                if let activity = activityIndicator {
                    return call(element).asObservable()
                        .trackActivity(activity)
                        .materialize()
                } else {
                    return call(element).asObservable()
                        .materialize()
                }
            }
        .share(replay: 1)
        
        return (
            stream.compactMap { $0.element }.asDriver(onErrorDriveWith: .never()),
            stream.compactMap { $0.error }.asDriver(onErrorDriveWith: .never())
        )
    }
}

extension ObservableConvertibleType {
    public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<Element> {
        return activityIndicator.trackActivityOfObservable(self)
    }
}
