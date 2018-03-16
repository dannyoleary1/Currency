//
//  AllCurrencies.swift
//  Currency
//
//  Created by Danny O'Leary on 15/03/2018.
//  Copyright © 2018 WIT. All rights reserved.
//

import Foundation
import UIKit

/******************************************************************************
 // This is a class for setting up objects that are not currently in the
 // tableView. It will be used as an additional feature to add more currencies
 *****************************************************************************/
class AllCurrencies {
    class func additionalCurrencies() -> [CurrencyObject] {
        var currencyList = [CurrencyObject]()
        currencyList.append(CurrencyObject(fullName: "Chineese Yuan", symbol: "CNY", value: "1.00", flag: "🇨🇳"))
        currencyList.append(CurrencyObject(fullName: "Polish Zloty", symbol: "PLN", value: "1.00", flag: "🇵🇱"))
        currencyList.append(CurrencyObject(fullName: "Thai Baht", symbol: "THB", value: "1.00", flag: "🇹🇭"))
        currencyList.append(CurrencyObject(fullName: "Bulgarian Lev", symbol: "BGN", value: "1.00", flag: "🇧🇬"))
        currencyList.append(CurrencyObject(fullName: "Swedish Krona", symbol: "SEK", value: "1.00", flag: "🇸🇪"))
        currencyList.append(CurrencyObject(fullName: "Israeli Shekel", symbol: "ILS", value: "1.00", flag: "🇮🇱"))
        currencyList.append(CurrencyObject(fullName: "Brazilian Real", symbol: "BRL", value: "1.00", flag: "🇧🇷"))
        currencyList.append(CurrencyObject(fullName: "Danish Krone", symbol: "DDK", value: "1.00", flag: "🇩🇰"))
        currencyList.append(CurrencyObject(fullName: "Russian Ruble", symbol: "RUB", value: "1.00", flag: "🇷🇺"))
        currencyList.append(CurrencyObject(fullName: "Icelandic Króna", symbol: "ISK", value: "1.00", flag: "🇮🇸"))
        currencyList.append(CurrencyObject(fullName: "Croatian Kuna", symbol: "HRK", value: "1.00", flag: "🇭🇷"))
        currencyList.append(CurrencyObject(fullName: "Mexican Peso", symbol: "MXN", value: "1.00", flag: "🇲🇽"))
        currencyList.append(CurrencyObject(fullName: "Romanian Leu", symbol: "RON", value: "1.00", flag: "🇷🇴"))
        currencyList.append(CurrencyObject(fullName: "Singapore Dollar", symbol: "SGD", value: "1.00", flag: "🇸🇬"))
        currencyList.append(CurrencyObject(fullName: "Turkish Lira", symbol: "TRY", value: "1.00", flag: "🇹🇷"))
        currencyList.append(CurrencyObject(fullName: "Norwegian Krone", symbol: "NOK", value: "1.00", flag: "🇳🇴"))
        currencyList.append(CurrencyObject(fullName: "Hungarian Forint", symbol: "HUF", value: "1.00", flag: "🇭🇺"))
        currencyList.append(CurrencyObject(fullName: "New Zealand Dollar", symbol: "NZD", value: "1.00", flag: "🇳🇿"))
        currencyList.append(CurrencyObject(fullName: "Malaysian Ringgit", symbol: "MYR", value: "1.00", flag: "🇲🇾"))
        currencyList.append(CurrencyObject(fullName: "Indonesian Rupiah", symbol: "IDR", value: "1.00", flag: "🇮🇩"))
        currencyList.append(CurrencyObject(fullName: "South Korean Won", symbol: "KRW", value: "1.00", flag: "🇰🇷"))
        currencyList.append(CurrencyObject(fullName: "Indian Rupee", symbol: "INR", value: "1.00", flag: "🇮🇳"))
        currencyList.append(CurrencyObject(fullName: "Philippine Piso", symbol: "PHP", value: "1.00", flag: "🇵🇭"))
        currencyList.append(CurrencyObject(fullName: "Czech Koruna", symbol: "CZK", value: "1.00", flag: "🇨🇿"))
        currencyList.append(CurrencyObject(fullName: "Hong Kong Dollar", symbol: "HKD", value: "1.00", flag: "🇭🇰"))
        currencyList.append(CurrencyObject(fullName: "South African Rand", symbol: "ZAR", value: "1.00", flag: "🇿🇦"))
        return currencyList
    }
}
