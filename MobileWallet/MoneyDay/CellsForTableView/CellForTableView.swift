//
//  CellForTableView.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 13.12.21.
//

import UIKit

class CellForTableView: UITableViewCell {
    var optionsVC: Options?
    let dateLabel = UILabel(font: UIFont(name: "Limelight", size: 20), aligment: .left)
    let amountLabel = UILabel(font: UIFont(name: "Limelight", size: 20), aligment: .right)
    let typeOfAmountLabel = UILabel(font: UIFont(name: "Limelight", size: 20), aligment: .left)
    let recipientsAccount = UILabel(font: UIFont(name: "Limelight", size: 20), aligment: .right)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [self] in
            setConstraints()
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
        let amountAndTypeStackView = UIStackView(arrangedSubwiews: [typeOfAmountLabel,amountLabel], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        self.addSubview(amountAndTypeStackView)
        NSLayoutConstraint.activate([
        amountAndTypeStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        amountAndTypeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
        amountAndTypeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
        amountAndTypeStackView.heightAnchor.constraint(equalToConstant: 25)])
        
        let dateAndRecipientsAccountStackView = UIStackView(arrangedSubwiews: [dateLabel, recipientsAccount], axis: .horizontal, spacing: 10, distribution: .fillProportionally)
        self.addSubview(dateAndRecipientsAccountStackView)
        NSLayoutConstraint.activate([
            dateAndRecipientsAccountStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            dateAndRecipientsAccountStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            dateAndRecipientsAccountStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            dateAndRecipientsAccountStackView.heightAnchor.constraint(equalToConstant: 25)])
    }
}
