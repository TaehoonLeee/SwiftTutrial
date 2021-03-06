import Combine

class StockDetailViewModel: BaseViewModel {
    
    @Published
    var isLoading = false
    
    @Published
    var errorMsg: String?
    
    @Published
    var timeSeries: TimeSeries?
    
    @Published
    var stock: Stock?
    
    let useCase: GetStockDetailUseCase
    
    init(useCase: GetStockDetailUseCase) {
        self.useCase = useCase
        super.init()
    }
    
    func viewDidLoad(stock: Stock, symbol: String) {
        self.stock = stock
        isLoading = true
        
        useCase.execute(keyword: symbol).sink { [self] completion in
            isLoading = false
            
            switch completion {
                case .failure(let error):
                    self.errorMsg = error.localizedDescription
                case .finished: break
            }
        } receiveValue: { value in
            var timeSeries = value
            timeSeries.generateMonthInfoList()
            self.timeSeries = timeSeries
        }.store(in: &subscriber)
    }
}
