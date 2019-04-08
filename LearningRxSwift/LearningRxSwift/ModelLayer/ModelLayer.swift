import Foundation
import RxSwift

typealias MessagesClosure = ([Message]) -> Void
typealias VoidClosure = () -> Void
typealias PhotoDescriptionsClosure = ([PhotoDescription]) -> Void

class ModelLayer {

    let photoDescriptions = Variable<[PhotoDescriptionEntity]>([])

    static let shared = ModelLayer()
    
    private var bag = DisposeBag()
    private var networkLayer = NetworkLayer() //normally injected as an interface
    private var persistanceLayer = PersistanceLayer.shared
    private var translationLayer = TranslationLayer()

    func initDatabase() {
        persistanceLayer.initDatabase()
    }
}

extension ModelLayer {

    func loadAllPhotoDescriptions() {   // result may be immediate, but use async callbacks
        persistanceLayer.loadAllPhotoDescriptions { photoDescriptions in // [weak self] assuming we have bigger problems if the model layer doesn't exist

            let entities = photoDescriptions.map(self.translationLayer.convert)
            self.photoDescriptions.value = entities
        }
    }
}
