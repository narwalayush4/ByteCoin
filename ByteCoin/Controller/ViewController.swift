//
//  ViewController.swift
//  ByteCoin
//
//  Created by Ayush Narwal on 01/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
        
        currencyLabel.text = "AUD"
        coinManager.getCoinPrice("AUD")
    }
    
}

//MARK: - UIPickerViewDataSource
extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        currencyLabel.text = selectedCurrency
        bitcoinLabel.text = "..."
        coinManager.getCoinPrice(selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate
extension ViewController : CoinManagerDelegate {
    func didUpdatePrice(coinManager: CoinManager, exchangeRate: ExchangeRate?) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = exchangeRate?.roundedRate
        }
    }
    func didFailWithError(error: Error?) {
        print(error!)
    }
}

