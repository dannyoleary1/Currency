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
    
    //this is our tableView where all our currencies will be stored.
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
        
        //Create a list of static currencies and then display them as part of the table view
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

        self.convert(self)
    }
    
    /*****************************************************************************
    // This function is responsible for adding the currencies to a dictionary.
    // The dictionary will be used to populate the tableView.
    ******************************************************************************/
    func createCurrencyList(){
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
    
    /*****************************************************************************
     // This function is an asynchronus call to the api which will get back the latest
     // results in a JSON format. It includes a plugin called 'NSActivityIndicatorView'.
     // https://github.com/ninjaprox/NVActivityIndicatorView
     ******************************************************************************/
    func getConversionTable(){
        let urlStr:String = "https://api.fixer.io/latest"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        
        //setup a frame for activity indicator and then set it to a type, and color.
        let x = self.view.frame.width / 2
        let y = self.view.frame.height / 2
        let frame = CGRect(x: (x - 40), y: (y - 50), width: 45, height: 45)
        var activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator.type = . ballScale
        activityIndicator.color = UIColor.red
        
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        
            if error == nil{
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                    if let ratesData = jsonDict["rates"] as? NSDictionary {
                        for rate in ratesData{
                            let name = String(describing: rate.key)
                            let rate = (rate.value as? NSNumber)?.doubleValue
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
                            self.dateformatter.dateFormat = "dd/MM/yyyy hh:mm a"
                            self.lastUpdatedDate = Date()
                            self.lastUpdatedDateLabel.text = self.dateformatter.string(from: self.lastUpdatedDate)
                            
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
    
    /*****************************************************************************
     // This function is responsible for passing the convert function from the button.
     // It passes to the convertCurrencies() where it will update the table, and rates.
     ******************************************************************************/
    @IBAction func convert(_ sender: Any) {
        //TODO check if this is meant to make a new call.
        //getConversionTable()
       convertCurrencies()
    }
    
    /*****************************************************************************
     // This function is responsible for refreshing the current rate. It first updates
     // the newer rates, and then it converts them which will update the rates in the
     // table view.
     ******************************************************************************/
    @IBAction func refresh(_ sender: Any){
        //TODO Is this supposed to refresh to 1.0?
        getConversionTable()
        convertCurrencies()
    }
    
    /*****************************************************************************
     // Function responsible for converting the currencys by the base currency.
     // It changes the values to represent this in the currencyDict, and then
     // reloads the tableView.
     ******************************************************************************/
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
        //TODO I do not think these are needed. Make sure
       // lastUpdatedDate = Date()
       // lastUpdatedDateLabel.text = dateformatter.string(from: lastUpdatedDate)
    }
    
    /*****************************************************************************
     // Function for setting how many Sections we want in our tableView. In our case
     // it will always be one.
     ******************************************************************************/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*****************************************************************************
     // Function that sets up the number of cells/ rows in the table. It will be the
     // ammount of currencies that we have in the system.
     ******************************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyDict.count
    }
    
    /*****************************************************************************
     // Function that iterates through every cell and assigns the corresponding values
     // from the array to the entry in the cell.
     ******************************************************************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyTableView
        
        //getting the currency for the specified position
        let currentCur: CurrencyObject
        currentCur = Array(currencyDict.values)[indexPath.row]
        
        cell.fullName.text = currentCur.fullName
        cell.symbol.text = currentCur.symbol
        cell.value.text = currentCur.value
        cell.flag.text = currentCur.flag
        return cell
    }
    
    /*****************************************************************************
     // Function that deals with the add button. It displays a list of all the other
     // currencies that are not static in the system. It displays a PickerView using
     // a plugin called 'ActionSheetPicker_3_0'. When picked, it wil add the currency
     // to the currencyDict dictionary and update the table to represent the change.
     // https://github.com/skywinder/ActionSheetPicker-3.0
     ******************************************************************************/
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
}
