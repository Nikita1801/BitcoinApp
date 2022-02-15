
import Foundation
import UIKit


protocol CoinManagerDelegate{
    func didUpdateUI(price: String, currency: String)
    func didFailWithError(error : Error)
}

struct CoinManager  {
    var delegate : CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "6614964D-C825-4454-9726-B8BC59FEE854"
    
    let currencyArray = ["AUD", "USD","RUB","EUR","CNY","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","CAD","SEK","SGD","BRL","ZAR"]
    
    
    func getCoinPrice(for currency : String) {
        
    let finalURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
   
    if let url = URL(string : finalURL) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {(data, response, error ) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let bitcoinPrice = parseJSON(safeData){
                        
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        self.delegate?.didUpdateUI( price: priceString, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
        }
        catch{
            print(error)
            return nil
        }
    }
    
}

