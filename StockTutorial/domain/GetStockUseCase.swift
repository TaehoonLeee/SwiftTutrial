import Foundation
import Combine

class GetStockUseCase {
    
    private let stockRepository: StockRepository
    
    init(stockRepository: StockRepository) {
        self.stockRepository = stockRepository
    }
    
    func execute(keyword: String) -> AnyPublisher<StockResponse, Error> {
        return stockRepository.fetchStockPublisher(keyword: keyword)
    }
}
