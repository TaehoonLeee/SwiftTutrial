import UIKit
import Pure

class StockDetailController: BaseViewController, FactoryModule {
    
    struct Dependency {
        let stock: Stock
        let viewModel: StockDetailViewModel
    }
    
    let selfView = StockDetailView()
    let viewModel: StockDetailViewModel
    var coordinator: MainCoordinator?
    
    let stock: Stock
    
    required init(dependency: Dependency, payload: ()) {
        stock = dependency.stock
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableScrollWhenKeyboardAppeared(scrollView: selfView.scrollView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad(stock: stock, symbol: stock.symbol ?? "")
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeListener()
    }
    
    override func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Detail"
        
        view.addSubview(selfView)
        selfView.translatesAutoresizingMaskIntoConstraints = false
        selfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        selfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        selfView.bottomView.dateInputView.textField.delegate = self
    }
    
    func bind() {
        viewModel.$timeSeries.sink { timeSeries in
            guard let timeSeries = timeSeries else { return }
            print(timeSeries.monthInfoList)
        }.store(in: &subscriber)
        
        viewModel.$stock.sink { stock in
            guard let stock = stock else { return }
            self.selfView.topView.configureUI(stock: stock)
            if let currency = stock.currency {
                self.selfView.bottomView.configureUI(currency: currency)
            }
        }.store(in: &subscriber)
        
        viewModel.$errorMsg.sink { errorMsg in
            guard let errorMsg = errorMsg else { return }
            print(errorMsg)
        }.store(in: &subscriber)
        
        viewModel.$isLoading.sink { isLoading in
            self.selfView.loadingView.isHidden = !isLoading
        }.store(in: &subscriber)
    }
}

extension StockDetailController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == selfView.bottomView.dateInputView.textField {
            coordinator?.dateInputTextFieldTapped()
            
            return false
        }
        
        return true
    }
}
