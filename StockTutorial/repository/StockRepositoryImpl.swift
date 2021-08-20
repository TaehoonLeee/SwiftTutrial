import Combine
import Foundation

class StockRepositoryImpl: StockRepository {
    
    let apiKey: String = "CTPPID37025Z6VQ9"
    let decoder = JSONDecoder()
    
    func fetchStockPublisher(keyword: String) -> AnyPublisher<StockResponse, Error> {
        let queryResult = parseQueryString(text: keyword)
        var query = ""
        
        switch queryResult {
            case .failure(let error):
                return Fail(error: error).eraseToAnyPublisher()
            case .success(let value):
                query = value
        }
        
        let urlResult = parseURL(urlString: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(query)&apikey=\(apiKey)")
        
        switch urlResult {
            case .failure(let error):
                return Fail(error: error).eraseToAnyPublisher()
            case .success(let url):
                return URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .decode(type: StockResponse.self, decoder: decoder)
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher()
        }
    }
    
    func fetchTimeSeriesPublisher(keyword: String) -> AnyPublisher<TimeSeries, Error> {
        let queryResult = parseQueryString(text: keyword)
        var query = ""
        
        switch queryResult {
            case .failure(let error):
                return Fail(error: error).eraseToAnyPublisher()
            case .success(let value):
                query = value
        }
        
        let urlResult = parseURL(urlString: "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(query)&apikey=\(apiKey)")
        
        switch urlResult {
            case .failure(let error):
                return Fail(error: error).eraseToAnyPublisher()
            case .success(let url):
                return URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .decode(type: TimeSeries.self, decoder: decoder)
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher()
        }
    }
    
    private func parseURL(urlString: String) -> Result<URL, Error> {
        if let url = URL(string: urlString) {
            return .success(url)
        } else {
            let error: MyError = .badUrl
            return .failure(error)
        }
    }
    
    private func parseQueryString(text: String) -> Result<String, Error> {
        if let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return .success(query)
        } else {
            let error: MyError = .encoding
            return .failure(error)
        }
    }
}
