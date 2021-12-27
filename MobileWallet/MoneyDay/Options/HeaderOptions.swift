//
//  HeaderOptions.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 12.12.21.
//

import Foundation
import UIKit

class HeaderOptions: UITableViewHeaderFooterView {
    
    let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = "Header"
        headerLabel.font = UIFont(name: "Limelight", size: 15)
        return headerLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
