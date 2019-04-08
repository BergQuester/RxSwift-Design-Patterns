import UIKit
import RxSwift
import RxCocoa

private var DefaultCellId = "Default"

class DatabaseExampleViewController: UITableViewController {
    
    private let presenter = DatabaseExamplePresenter()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: DefaultCellId)

        presenter.photoDescriptions
                 .asObservable()
                 .observeOn(MainScheduler.instance)
                 .bind(to: tableView.rx.items(cellIdentifier: DefaultCellId)) { (index, photoDescription, cell) in
                    cell.textLabel?.text = photoDescription.title
                }.disposed(by: bag)
    }
}
