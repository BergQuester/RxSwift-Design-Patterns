//

import UIKit
import RxSwift
import RxCocoa

class ReactiveUIViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var acceptButton: UIButton!
    
    fileprivate var presenter = ReactiveUIPresenter() //normally injected as an interface
    
    var mainThreadPointer: Thread!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainThreadPointer = Thread.current
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        tableView.dataSource = self
    }
    
    @IBAction func acceptTapped(_ sender: UIButton) {
        print("Friends Accepted")
    }
}



//Parts 1 & 2

//MARK: - UITableViewDataSource
extension ReactiveUIViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = presenter.friends[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
            cell.textLabel?.text = friend.description

        return cell
    }
}













