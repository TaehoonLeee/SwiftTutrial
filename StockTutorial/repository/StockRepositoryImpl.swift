import Combine
import Foundation

class StockRepositoryImpl: StockRepository {
    let apiKey: String = "CTPPID37025Z6VQ9"
    let decoder = JSONDecoder()
    
    func fetchStockPublisher(keyword: String) -> AnyPublisher<StockResponse, Error> {
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keyword)&apikey=\(apiKey)"
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: StockResponse.self, decoder: decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
