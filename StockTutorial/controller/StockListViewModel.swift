import RxSwift
import Combine

class StockListViewModel {
    
    @Published
    var stocks: [Stock] = []
    
    @Published
    var errorMsg: String?
    
    @Published
    var isLoading = false
    
    var subscriber: Set<AnyCancellable> = .init()
    var currentStocks: [Stock] = []
    
    let useCase: GetStockUseCase
    
    init(useCase: GetStockUseCase) {
        self.useCase = useCase
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
    
}
