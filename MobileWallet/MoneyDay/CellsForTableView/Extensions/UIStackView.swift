//
//  UIStackView.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 13.12.21.
//

import UIKit

extension UIStackView  {
    convenience init(arrangedSubwiews: [UILabel],axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubwiews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
