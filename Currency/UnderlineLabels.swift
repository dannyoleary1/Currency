//
//  UnderlineLabels.swift
//  Currency
//
//  Created by Danny O'Leary on 11/03/2018.
//  Copyright © 2018 WIT. All rights reserved.
//

//http://www.phoumangkor.com/2017/02/how-to-custom-border-line-on-bottom-of.html
import UIKit

extension UIView {
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}
