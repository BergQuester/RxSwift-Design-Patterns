import UIKit
import RxSwift
import RxCocoa

private var DefaultCellId = "Default"

class DatabaseExampleViewController: UITableViewController {
    
    private let presenter = DatabaseExamplePresenter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DefaultCellId)
    }
}
