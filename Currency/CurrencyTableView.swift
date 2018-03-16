//
//  CurrencyTableView.swift
//  Currency
//
//  Created by Danny O'Leary on 15/03/2018.
//  Copyright © 2018 WIT. All rights reserved.
//

import UIKit

/***********************************************************************
 // For our custom tableCell. This is what will be displayed in the
 // TableView.
 **********************************************************************/
class CurrencyTableView: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
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
