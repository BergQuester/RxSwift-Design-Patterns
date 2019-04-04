//
//  SimpleRx.swift
//  LearningRxSwift
//
//  Created by Daniel Bergquist on 4/3/19.
//  Copyright © 2019 Jon Bott. All rights reserved.
//

import Foundation
import RxSwift

class SimpleRx {
    var bag = DisposeBag()
}

// MARK: - Variables
extension SimpleRx {
    static var shared = SimpleRx()

    func variables() {
        print("~~~~~~~Variable~~~~~~~")

        let someInfo = Variable("some value")
        print("someInfo.value: \(someInfo.value)")

        let plainString = someInfo.value
        print("plainString: \(plainString)")

        someInfo.value = "something new"
        print("someInfo.value: \(someInfo.value)")

        someInfo.asObservable().subscribe(onNext: { newValue in
            print("value has changed \(newValue)")
        }, onError: { _ in
            //optional cleanup block
        }).disposed(by: bag)

        someInfo.value = "something again"

        //NOTE: Variable will never receive onError and onComplete events
    }
}

//MARK: - Subjects
extension SimpleRx {
    func subjects() {
        let behavoirSubject = BehaviorSubject(value: 24)

        let disposable = behavoirSubject.subscribe(onNext: { newValue in
            print("behavoirSubject subscription: \(newValue)")
        }, onError: { error in
            print("error: \(error.localizedDescription)")
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
        })

        behavoirSubject.onNext(34)
        behavoirSubject.onNext(48)
        behavoirSubject.onNext(48) //dupes show as new event by default

        //1 on error
//        let customError = CustomError.forcedError
//        behavoirSubject.onError(customError) // Will also trigger dispose
//        behavoirSubject.onNext(109) // Will never show

        //2 on completed
//        behavoirSubject.onCompleted() // Will also trigger dispose
//        behavoirSubject.onNext(10983) // Will never show

        //3 on dispose
//        disposable.dispose()

        //4 can bind observables to subjects
        let numbers = Observable.from([1, 2, 3, 4, 5, 6, 7])
        numbers.subscribe(onNext: { number in
            print("observable Subscription: \(number)")
        }).disposed(by: bag)

        numbers.bind(to: behavoirSubject).disposed(by: bag)
    }
}
