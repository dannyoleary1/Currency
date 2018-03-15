//
//  ViewController.swift
//  Currency
//
//  Created by Robert O'Connor on 18/10/2017.
//  Copyright © 2017 WIT. All rights reserved.
//

import UIKit

class CurrencyObject{
    var fullName: String!
    var symbol: String!
    var value: String!
    var flag: String!
    init(fullName: String?, symbol: String?, value: String?, flag: String?) {
        self.fullName = fullName
        self.symbol = symbol
        self.value = value
        self.flag = flag
    }
}

class CurrencyTableView: UITableViewCell {
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var flag: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}



class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var currencyDict:Dictionary = [String:Currency]()
    var testCurrencyDict:Dictionary = [String:CurrencyObject]()
    
    //MARK Model holders
    var currencyArray = [Currency]()
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

        createCurrencyListv2()
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
    
    func createCurrencyListv2(){
        //let c:Currency = Currency(name: name, rate: rate!, flag: flag, symbol: symbol)!
        //self.currencyDict[name] = c
        testCurrencyDict["GBP"] = CurrencyObject(fullName: "Great British Pound", symbol: "£", value: "1.00", flag: "🇬🇧")
        testCurrencyDict["USD"] = CurrencyObject(fullName: "United States Dollar", symbol: "$",
                                          value: "1.00", flag: "🇺🇸")
        testCurrencyDict["AUD"] = CurrencyObject(fullName: "Austrailian Dollar", symbol: "A$",
                                          value: "1.00", flag: "🇦🇺")
        testCurrencyDict["CHF"] = CurrencyObject(fullName: "Swiss Frank", symbol: "CHF", value: "1.00", flag: "🇨🇭")
        testCurrencyDict["JPY"] = CurrencyObject(fullName: "Japeneese Yen", symbol: "¥", value: "1.00", flag: "🇯🇵")
        testCurrencyDict["CAD"] = CurrencyObject(fullName: "Canadian Dollar", symbol: "$", value: "1.00", flag: "🇨🇦")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getConversionTable(){
        let urlStr:String = "https://api.fixer.io/latest"
        var request = URLRequest(url: URL(string: urlStr)!)
        request.httpMethod = "GET"
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
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
                            if let currentCurrency = self.testCurrencyDict[name]{
                                currentCurrency.value = String(format: "%.02f", rate!)
                                self.testCurrencyDict[name] = currentCurrency
                            }
                            else{
                                print("Ignoring currency: \(String(describing: rate))")
                            }
                        }
                        indicator.stopAnimating()
                        self.lastUpdatedDate = Date()
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
       convertCurrencies()
    }
    
    @IBAction func refresh(_ sender: Any){
        convertCurrencies()
    }
    
    func convertCurrencies(){
        var result = 0.0
        if let euro = Double(baseTextField.text!) {
            convertValue = euro
            for (key, value) in testCurrencyDict{
                if let entry = self.testCurrencyDict[key]{
                    result = convertValue * Double(entry.value)!
                }
                testCurrencyDict[key]?.value = String(format: "%.02f", result)
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
        return testCurrencyDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyTableView
        
        //getting the hero for the specified position
        let currentCur: CurrencyObject
        currentCur = Array(testCurrencyDict.values)[indexPath.row]

        cell.symbol.text = currentCur.symbol
        cell.value.text = currentCur.value
        cell.flag.text = currentCur.flag
        return cell
    }
    

    
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     */
}

