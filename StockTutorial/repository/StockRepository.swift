import Combine

protocol StockRepository {
    func fetchStockPublisher(keyword: String) -> AnyPublisher<StockResponse, Error>
    func fetchTimeSeriesPublisher(keyword: String) -> AnyPublisher<TimeSeries, Error>
}
