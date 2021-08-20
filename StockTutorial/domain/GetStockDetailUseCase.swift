import Combine

class GetStockDetailUseCase {
    
    private let stockRepository: StockRepository
    
    init(stockRepository: StockRepository) {
        self.stockRepository = stockRepository
    }
    
    func execute(keyword: String) -> AnyPublisher<TimeSeries, Error> {
        return stockRepository.fetchTimeSeriesPublisher(keyword: keyword)
    }
}
