import Foundation
import RxSwift

class NetworkExamplePresenter {

    fileprivate let modelLayer = ModelLayer.shared

    //path 1
//    public let messages = Variable<[Message]>([])

    // path 2
    public var messages: Variable<[Message]> { return modelLayer.messages}

    init() {
//        //path 1
//        modelLayer.loadMessages { [weak self] messages in
//            self?.messages.value = messages
//        }
        modelLayer.loadMessages()
    }
}

