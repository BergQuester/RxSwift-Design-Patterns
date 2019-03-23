import Foundation
import RxSwift

typealias MessagesClosure = ([Message]) -> Void
typealias VoidClosure = () -> Void
typealias PhotoDescriptionsClosure = ([PhotoDescription]) -> Void

class ModelLayer {
    static let shared = ModelLayer()
    
    private var bag = DisposeBag()
    private var networkLayer = NetworkLayer() //normally injected as an interface
    private var persistanceLayer = PersistanceLayer.shared
    private var translationLayer = TranslationLayer()

    func initDatabase() {
        persistanceLayer.initDatabase()
    }
}
