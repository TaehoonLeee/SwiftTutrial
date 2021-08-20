import UIKit
import Pure
import RxCocoa
import RxSwift

class StockListController: BaseViewController, FactoryModule {
    
    struct Dependency {
        let viewModel: StockListViewModel
    }
    
    let selfView = StockListView()
    let viewModel: StockListViewModel
    
    required init(dependency: Dependency, payload: ()) {
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableScrollWhenKeyboardAppeared(scrollView: selfView.tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeListener()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureUI() {
        view.addSubview(selfView)
        selfView.translatesAutoresizingMaskIntoConstraints = false
        selfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        selfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        
        navigationItem.searchController = selfView.searchViewController
    }
    
    func bind() {
        selfView.searchViewController.searchBar.rx.text
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { query in
                guard let query = query, !query.isEmpty else { return }
                self.viewModel.searchQueryChanged(query: query)
            }).disposed(by: disposeBag)
        
        viewModel.$errorMsg.sink { errorMsg in
            guard let message = errorMsg, !message.isEmpty else { return }
            print("error: \(message)")
        }.store(in: &subscriber)
        
        viewModel.$stocks.sink { stocks in
            self.selfView.tableView.reloadData()
        }.store(in: &subscriber)
        
        viewModel.$isLoading.sink { isLoading in
            self.selfView.loadingView.isHidden = !isLoading
        }.store(in: &subscriber)
    }
}
