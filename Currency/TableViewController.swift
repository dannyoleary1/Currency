//
//  TableViewController.swift
//  Currency
//
//  Created by Danny O'Leary on 12/03/2018.
//  Copyright © 2018 WIT. All rights reserved.
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

class TableViewController: UITableViewController {

    var currencyDict:Dictionary = [String:Currency]()
    var currencyObj  = [CurrencyObject]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCurrencyList()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createCurrencyList(){
        //let c:Currency = Currency(name: name, rate: rate!, flag: flag, symbol: symbol)!
        //self.currencyDict[name] = c
        currencyObj.append(CurrencyObject(fullName: "Great British Pound", symbol: "£", value: "1.0", flag: "🇬🇧"))
        currencyObj.append(CurrencyObject(fullName: "United States Dollar", symbol: "$",
                                          value: "1.0", flag: "🇺🇸"))
        currencyObj.append(CurrencyObject(fullName: "Austrailian Dollar", symbol: "A$",
                                          value: "1.0", flag: "🇦🇺"))
        currencyObj.append(CurrencyObject(fullName: "Swiss Frank", symbol: "CHF", value: "1.0", flag: "🇨🇭"))
        currencyObj.append(CurrencyObject(fullName: "Japeneese Yen", symbol: "¥", value: "1.0", flag: "🇯🇵"))
        currencyObj.append(CurrencyObject(fullName: "Canadian Dollar", symbol: "$", value: "1.0", flag: "🇨🇦"))
    }

    // MARK: - Table view data source


    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyObj.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyTableView
        
        //getting the hero for the specified position
        let currentCur: CurrencyObject
        currentCur = currencyObj[indexPath.row]
        
        //displaying values
        print ("_______")
        print (indexPath.row)
        print (currentCur.symbol)
        print (cell)
        print (cell.symbol)
        
        cell.symbol.text = currentCur.symbol
        cell.value.text = currentCur.value
        cell.flag.text = currentCur.flag
        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
