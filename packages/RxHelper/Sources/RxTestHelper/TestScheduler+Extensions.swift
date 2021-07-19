//
//  File.swift
//  
//
//  Created by Serhan Aksut on 20.07.2021.
//

import RxSwift
import RxCocoa
import RxTest

extension TestScheduler {
    func cold<Element>(_ events: Recorded<Event<Element>>...) -> Observable<Element> {
        createColdObservable(events)
            .asObservable()
    }

    func hot<Element>(_ events: Recorded<Event<Element>>...) -> Observable<Element> {
        createHotObservable(events)
            .asObservable()
    }

    func single<Element>(_ time: TestTime, _ element: Element) -> Single<Element> {
        createColdObservable([
            .next(time, element),
            .completed(time)
        ])
        .asSingle()
    }

    func single<Element>(_ time: TestTime, _ error: Error) -> Single<Element> {
        createColdObservable([
            .error(time, error)
        ])
        .asSingle()
    }

    func record<Source: ObservableConvertibleType>(source: Source) -> TestableObserver<Source.Element> {
        let observer = self.createObserver(Source.Element.self)
        let disposable = source.asObservable().bind(to: observer)
        self.scheduleAt(100000) {
            disposable.dispose()
        }
        return observer
    }
}

