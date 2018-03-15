//
//  StatusBarColor.swift
//  Currency
//
//  Created by Danny O'Leary on 15/03/2018.
//  Copyright © 2018 WIT. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
