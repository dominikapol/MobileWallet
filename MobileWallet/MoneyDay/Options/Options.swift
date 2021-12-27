//
//  Options.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 12.12.21.
//

import Foundation
import UIKit

protocol OptionsView: AnyObject {
    
}

class Options: UITableViewController, OptionsView {
    var presenter: OptionsPresenterProtocol = OptionsPresenter()
    let idOptionsCell = "idOptionsCell"
    let idOptionsHeader = "idOptionsHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.view = self
        presenter.viewDidLoad()
        title = "Options"
        tableView.backgroundColor = UIColor(named: "customWhiteCream")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OptionsCell.self, forCellReuseIdentifier: idOptionsCell)
        tableView.register(HeaderOptions.self, forHeaderFooterViewReuseIdentifier: idOptionsHeader)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
    }
    
    func insertAmount(amount: String) {
        presenter.insertAmountPresenter(amount: amount)
    }
    func insertType(type: String) {
        presenter.insertTypePresenter(type: type)
    }
    func insertDate(date: String) {
        presenter.insertDatePresenter(date: date)
    }
    func insertrecipientsAccount(recipientsAccount: String) {
        presenter.insertTimerecipientsAccount(recipientsAccount: recipientsAccount)
    }
    
    @objc private func saveButtonPressed() {
        print("its okey")
        presenter.save()
        navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 1
        case 3:
            return 1
        default: return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsCell, for: indexPath) as! OptionsCell
        cell.cellConfiguration(indexPath: indexPath)
        cell.backgroundColor = UIColor(named: "customWhiteCream")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeader) as! HeaderOptions
        return header
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsCell
        switch indexPath {
        case [0,0]: alertDate(label: cell.nameCellLabel) { (numberWeekDay, date) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-YYYY"
            let dateString = dateFormatter.string(from: date as Date)
            self.insertDate(date: dateString)
        }
            
        case [0,1]: alertForType(label: cell.nameCellLabel, name: "Required payment account number", placeholder: "Enter the payment account number") { recipientsAccount in
            self.insertrecipientsAccount(recipientsAccount: recipientsAccount)
            print(recipientsAccount)
        }
            
        case [1,0]: alertForType(label: cell.nameCellLabel, name: "Payment amount", placeholder: "Enter the amount of payment") { amount in
            self.insertAmount(amount: amount)
        }
            
        case [1,1]: alertForType(label: cell.nameCellLabel, name: "Type of expenditure", placeholder: "Enter the type of expenditure") { type in
            self.insertType(type: type)
        }
            
        default: print("it's doesn't working:(")
        }
    }
}
