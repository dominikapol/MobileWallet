//
//  PiggyBankCell.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 9.12.21.
//

import Foundation
import UIKit

class PiggyBankCell: UITableViewCell {
    @IBOutlet private weak var imageWithDollar: UIImageView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet private weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
    }
    
    func update(with text: String) {
        moneyLabel.text = "+\(text)"
    }
    
}
