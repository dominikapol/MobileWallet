//
//  CellOfExchangeRate.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 23.12.21.
//

import Foundation
import UIKit

class CellOfExchangeRate: UITableViewCell {
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
    }
    
    func updateCell(with currency: String) {
        label.text = currency
    }
    
}
