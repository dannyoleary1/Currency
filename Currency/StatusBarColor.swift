//
//  StatusBarColor.swift
//  Currency
//
//  Created by Danny O'Leary on 15/03/2018.
//  Copyright © 2018 WIT. All rights reserved.
//

import UIKit

/********************************************************************************
 // This is a UIApplication extension which will setup a variable that I can then
 // call in AppDelegate to change the background color. 
 *******************************************************************************/
extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
