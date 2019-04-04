import UIKit
import RxSwift
import RxCocoa

class BasicExampleViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        realObservableExample()
    }
}

//Mark: - Real Observable Example
extension BasicExampleViewController {
    func realObservableExample() {
        loadPost()
            .asObservable()
        .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] posting in
                    self?.titleLabel.text = posting.title
                    self?.bodyLabel.text = posting.body
                }, onError: { [weak self] error in
                    self?.titleLabel.text = ""
                    self?.bodyLabel.text = ""
                    print("! an error occoured: \(error.localizedDescription)")
                }, onCompleted: {

                }).disposed(by: bag)
    }

    //usually done in network layer
    func loadPost() -> Observable<Posting> {
        return Observable.create { observer in
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts/5")! // Explicit unwrap only for example

            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                guard let data = data else {
                    observer.onError(CustomError.noDataFromServer)
                    return
                }
                guard let strongSelf = self else { return }

                let posting = strongSelf.parse(data)

                observer.onNext(posting)
                observer.onCompleted()
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }

    func parse(_ data: Data) -> Posting {
        let json = try! JSONSerialization.jsonObject(with: data) as! [String: Any] // do not try! in production code

        let posting = Posting(userId: try! json.value(for: "userId"),
            id: try! json.value(for: "id"),
            title: try! json.value(for: "title"),
            body: try! json.value(for: "body"))

        return posting
    }
}
