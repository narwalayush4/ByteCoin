//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Ayush Narwal on 01/07/23.
// DFF59CED-4A25-4B75-BD74-1F7D7FC00F10
// https://rest.coinapi.io/v1/exchangerate/BTC/USD/?apikey=DFF59CED-4A25-4B75-BD74-1F7D7FC00F10

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(coinManager : CoinManager, exchangeRate : ExchangeRate?)
    func didFailWithError(error : Error?)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    var delegate : CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(_ currency : String ){
        let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)/?apikey=DFF59CED-4A25-4B75-BD74-1F7D7FC00F10")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error)
                return
            }
            if let safeData = data {
                let exchangeRate = parseJson(safeData)
                delegate?.didUpdatePrice(coinManager: self, exchangeRate: exchangeRate)
                return
            }
        }
        task.resume()
    }
    
    func parseJson(_ data : Data) -> ExchangeRate? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ExchangeRate.self , from: data)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}

