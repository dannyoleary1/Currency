//
//  CurrencyObject.swift
//  Currency
//
//  Created by Danny O'Leary on 15/03/2018.
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
