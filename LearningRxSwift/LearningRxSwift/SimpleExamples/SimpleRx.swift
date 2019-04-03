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
