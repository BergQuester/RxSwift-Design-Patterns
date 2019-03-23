import UIKit
import RxSwift
import RxCocoa

class NetworkExampleViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    fileprivate var presenter = NetworkExamplePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkExampleTableViewCell.register(with: tableView)
    }
}

extension NetworkExampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
