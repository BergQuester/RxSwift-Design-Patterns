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
    }
}
