import Foundation

struct TimeSeries: Decodable {
    let meta: Meta
    let series: [String: OHLC]
    var monthInfoList: [MonthInfo] = []
    
    enum CodingKeys: String, CodingKey {
        case meta = "Meta Data"
        case series = "Monthly Adjusted Time Series"
    }
    
    struct Meta: Decodable {
        let symbol: String
        
        enum CodingKeys: String, CodingKey {
            case symbol = "2. Symbol"
        }
    }
    
    struct OHLC: Decodable {
        let open: String
        let close: String
        let adjustedClose: String
        
        enum CodingKeys: String, CodingKey {
            case open = "1. open"
            case close = "4. close"
            case adjustedClose = "5. adjusted close"
        }
    }
    
    mutating func generateMonthInfoList() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var monthInfoList: [MonthInfo] = []
        
        series.sorted { $0.key > $1.key }.forEach { (dateString, ohlc) in
            if let date = dateFormatter.date(from: dateString), let adjustedClose = Double(ohlc.adjustedClose), let adjustedOpen = calculateAdjustedOpen(ohlc: ohlc) {
                let monthInfo: MonthInfo = .init(date: date, adjustedOpen: adjustedOpen, adjustedClose: adjustedClose)
                
                monthInfoList.append(monthInfo)
            }
        }
        
        self.monthInfoList = monthInfoList
    }
    
    private func calculateAdjustedOpen(ohlc: OHLC) -> Double? {
        var adjustedOpen: Double?
        
        if let open = Double(ohlc.open), let close = Double(ohlc.close), let adjustedClose = Double(ohlc.adjustedClose) {
            adjustedOpen = open * (adjustedClose / close)
        }
        
        return adjustedOpen
    }
}
