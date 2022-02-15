
import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var coinManager = CoinManager()
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    

    @IBOutlet weak var currentLable: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitCoinLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component : Int) -> String? {
       return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(coinManager.currencyArray[row])
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        
    }
}

extension ViewController : CoinManagerDelegate {
    func didUpdateUI(price : String, currency : String) {
        
        DispatchQueue.main.async {
            self.currentLable.text = currency
            self.bitCoinLable.text = price
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

