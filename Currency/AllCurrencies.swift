//
//  AllCurrencies.swift
//  Currency
//
//  Created by Danny O'Leary on 15/03/2018.
//  Copyright © 2018 WIT. All rights reserved.
//

import Foundation
import UIKit

class AllCurrencies {
    class func additionalCurrencies() -> [CurrencyObject] {
        //var currencyList = ["CNY", "PLN", "THB", "BGN", "SEK", "ILS", "BRL", "DDK", "RUB", "ISK", "HRK", "MXN", "RON", "SGD", "TRY", "NOK", "HUF", "NZD", "MYR", "IDR", "KRW", "INR", "PHP", "CZK", "HKD", "ZAR"]
        var currencyList = [CurrencyObject]()
        currencyList.append(CurrencyObject(fullName: "Chineese Yuan", symbol: "CNY", value: "1.00", flag: "🇨🇳"))
        currencyList.append(CurrencyObject(fullName: "Polish Zloty", symbol: "PLN", value: "1.00", flag: "🇵🇱"))
        currencyList.append(CurrencyObject(fullName: "Thai Baht", symbol: "THB", value: "1.00", flag: "🇹🇭"))
        currencyList.append(CurrencyObject(fullName: "Bulgarian Lev", symbol: "BGN", value: "1.00", flag: "🇧🇬"))
        currencyList.append(CurrencyObject(fullName: "Swedish Krona", symbol: "SEK", value: "1.00", flag: "🇸🇪"))
        return currencyList
    }
}
