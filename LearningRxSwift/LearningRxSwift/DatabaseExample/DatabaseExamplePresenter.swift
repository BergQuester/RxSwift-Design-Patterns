import Foundation
import RxSwift

class DatabaseExamplePresenter {
    private let modelLayer = ModelLayer.shared //normally injected as an interface (with a singleton implementation)

    var photoDescriptions: Variable<[PhotoDescriptionEntity]> { return modelLayer.photoDescriptions }   // bubbling up var from lower layers

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.modelLayer.loadAllPhotoDescriptions()
        }
    }
}
