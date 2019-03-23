import UIKit
import RxSwift
import Result

class TasksExampleViewController: UIViewController {
    
    let presenter = TasksExamplePresenter() //normally injected
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
