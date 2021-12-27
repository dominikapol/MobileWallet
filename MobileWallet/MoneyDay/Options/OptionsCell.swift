//
//  OptionsCell.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 12.12.21.
//

import UIKit

class OptionsCell: UITableViewCell{
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "customCream")
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameCellLabel: UILabel = {
        let cellLabel = UILabel()
        cellLabel.font = UIFont(name: "Limelight", size: 15)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.text = "text"
        return cellLabel
    }()
    
    let repeatSwitch: UISwitch = {
      let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.onTintColor = UIColor(named: "customBlue")
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    let cellNameArray = [ [ "Date" , "Account number"],
                          [ "Cost" , "Type"],
                          [ "Please, check the entered data again" ],
                          [ "Repeat every month" ]]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
        
        repeatSwitch.addTarget(self, action: #selector(switchChanged(paramTarget: )), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func cellConfiguration(indexPath: IndexPath) {
        nameCellLabel.text = cellNameArray[indexPath.section][indexPath.row]
        if indexPath == [3,0] {
            repeatSwitch.isHidden = false
        }
    }
    
    @objc func switchChanged(paramTarget: UISwitch) {
        if paramTarget.isOn {
            print("ON") // добавлять повторение каждый месяц
        } else {
            print("Off")
        }
    }
    
    func setConstraints() {
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0), backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0), backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0), backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)])
        
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor), nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15)])
        self.contentView.addSubview(repeatSwitch)
        NSLayoutConstraint.activate([repeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor), repeatSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -20)])
    }
}
