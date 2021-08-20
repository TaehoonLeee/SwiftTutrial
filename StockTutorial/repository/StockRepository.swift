import Combine

protocol StockRepository {
    func fetchStockPublisher(keyword: String) -> AnyPublisher<StockResponse, Error>
}
