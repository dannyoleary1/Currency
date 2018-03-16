//
//  ViewController.swift
//  Currency
//
//  Created by Robert O'Connor on 18/10/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import ActionSheetPicker_3_0


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    var currencyDict:Dictionary = [String:CurrencyObject]()
    var baseCurrency:Currency = Currency.init(name:"EUR", rate:1, flag:"🇪🇺", symbol:"€")!
    var lastUpdatedDate:Date = Date()
    var convertValue:Double = 0
    
    
    //MARK Outlets
    //@IBOutlet weak var convertedLabel: UILabel!
    
    @IBOutlet weak var baseSymbol: UILabel!
    @IBOutlet weak var baseTextField: UITextField!
    @IBOutlet weak var baseFlag: UILabel!
    @IBOutlet weak var lastUpdatedDateLabel: UILabel!

    let dateformatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // print("currencyDict has \(self.currencyDict.count) entries")

        createCurrencyList()
        tableView.reloadData()
        
        // get latest currency values
        getConversionTable()
        convertValue = 1
        
        // set up base currency screen items
        baseTextField.text = String(format: "%.02f", baseCurrency.rate)
        baseSymbol.text = baseCurrency.symbol
        baseFlag.text = baseCurrency.flag
        
        // set up last updated date
        
        dateformatter.dateFormat = "dd/MM/yyyy hh:mm a"
        lastUpdatedDateLabel.text = dateformatter.string(from: lastUpdatedDate)
        
        
        
        baseTextField.delegate = self
        baseTextField.addDoneButtonToKeyboard(myAction: #selector(self.baseTextField.resignFirstResponder))

        //TODO eference and fiure out
        self.convert(self)
    }
    
    func createCurrencyList(){
        //let c:Currency = Currency(name: name, rate: rate!, flag: flag, symbol: symbol)!
        //self.currencyDict[name] = c
        currencyDict["GBP"] = CurrencyObject(fullName: "Great British Pound", symbol: "£", value: "1.00", flag: "🇬🇧")
        currencyDict["USD"] = CurrencyObject(fullName: "United States Dollar", symbol: "$",
                                          value: "1.00", flag: "🇺🇸")
        currencyDict["AUD"] = CurrencyObject(fullName: "Austrailian Dollar", symbol: "A$",
                                          value: "1.00", flag: "🇦🇺")
        currencyDict["CHF"] = CurrencyObject(fullName: "Swiss Frank", symbol: "CHF", value: "1.00", flag: "🇨🇭")
        currencyDict["JPY"] = CurrencyObject(fullName: "Japeneese Yen", symbol: "¥", value: "1.00", flag: "🇯🇵")
        currencyDict["CAD"] = CurrencyObject(fullName: "Canadian Dollar", symbol: "$", value: "1.00", flag: "🇨🇦")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getConversionTable(){
        let urlStr:String = "https://api.fixer.io/latest"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        
        let x = self.view.frame.width / 2
        let y = self.view.frame.height / 2
        let frame = CGRect(x: (x - 40), y: (y - 50), width: 45, height: 45)
        var activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator.type = . ballScale // add your type
        activityIndicator.color = UIColor.red // add your color
        
        self.view.addSubview(activityIndicator) // or use  webView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        
            if error == nil{
                //print(response!)
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                    // print(jsonDict)
                    
                    if let ratesData = jsonDict["rates"] as? NSDictionary {
                        //print(ratesData)
                        for rate in ratesData{
                            //print("#####")
                            let name = String(describing: rate.key)
                            let rate = (rate.value as? NSNumber)?.doubleValue
                            //var symbol:String
                            //var flag:String
                            if let currentCurrency = self.currencyDict[name]{
                                currentCurrency.value = String(format: "%.02f", rate!)
                                self.currencyDict[name] = currentCurrency
                            }
                            else{
                                print("Ignoring currency: \(String(describing: rate))")
                                print("Currency Name: \(String(name))")
                            }
                        }
                        DispatchQueue.main.async {
                            activityIndicator.stopAnimating()
                            activityIndicator.removeFromSuperview()
                            self.lastUpdatedDate = Date()
                        }
                    }
                }
                catch let error as NSError{
                    print(error)
                }
            }
            else{
                print("Error")
            }
        })
        task.resume()
        
    }
    
    @IBAction func convert(_ sender: Any) {
        //TODO check if this is meant to make a new call.
        //getConversionTable()
       convertCurrencies()
    }
    
    @IBAction func refresh(_ sender: Any){
        //TODO Is this supposed to refresh to 1.0?
        getConversionTable()
        convertCurrencies()
    }
    
    func convertCurrencies(){
        var result = 0.0
        if let euro = Double(baseTextField.text!) {
            convertValue = euro
            for (key, value) in currencyDict{
                if let entry = self.currencyDict[key]{
                    result = convertValue * Double(entry.value)!
                }
                currencyDict[key]?.value = String(format: "%.02f", result)
            }
        }
        tableView.reloadData()
        lastUpdatedDate = Date()
        lastUpdatedDateLabel.text = dateformatter.string(from: lastUpdatedDate)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyTableView
        
        //getting the hero for the specified position
        let currentCur: CurrencyObject
        currentCur = Array(currencyDict.values)[indexPath.row]
        
        cell.fullName.text = currentCur.fullName
        cell.symbol.text = currentCur.symbol
        cell.value.text = currentCur.value
        cell.flag.text = currentCur.flag
        return cell
    }
    
    
    @IBAction func buttonAdd(_ sender: Any) {
        var allC = AllCurrencies.additionalCurrencies()
        var names = [String]()
        for value in allC{
            names.append(value.fullName)
        }
        ActionSheetMultipleStringPicker.show(withTitle: "Add Currency", rows: [
            names,
            ], initialSelection: [1, 1], doneBlock: {
                picker, indexes, values in
                //refresh of the currencies is needed since they are not in the current cache
                
                let index = indexes![0] as! Int
                let currentEntry = allC[index]
                self.currencyDict[currentEntry.symbol] = currentEntry
                DispatchQueue.main.async {
                    self.getConversionTable()
                    self.tableView.reloadData()
                }
                
                
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     */
}

