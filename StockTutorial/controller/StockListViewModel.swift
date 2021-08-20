import RxSwift
import Combine

class StockListViewModel: BaseViewModel {
    
    @Published
    var stocks: [Stock] = []
    
    @Published
    var errorMsg: String?
    
    @Published
    var isLoading = false
    
    @Published
    var isEmpty = false
    
    var currentStocks: [Stock] = []
    
    let useCase: GetStockUseCase
    
    init(useCase: GetStockUseCase) {
        self.useCase = useCase
        super.init()
        reduce()
    }
    
    func searchQueryChanged(query: String) {
        isLoading = true
        
        useCase.execute(keyword: query).sink { completion in
            self.isLoading = false
            
            switch completion {
                case .failure(let error):
                    self.errorMsg = error.localizedDescription
                case .finished: break
            }
        } receiveValue: { stockResponse in
            self.isLoading = false
            self.currentStocks = stockResponse.items
            self.stocks = stockResponse.items
        }.store(in: &subscriber)
    }
    
    func reduce() {
        $stocks.sink { stocks in
            if stocks.count == 0 {
                self.isEmpty = true
            } else {
                self.isEmpty = false
            }
        }.store(in: &subscriber)
    }
    
}
