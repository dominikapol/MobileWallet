//
//  UILabel.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 14.12.21.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(font: UIFont?, aligment: NSTextAlignment) {
        self.init()
        self.font = font
        self.textColor = UIColor(named: "customPeach")
        self.textAlignment = aligment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
