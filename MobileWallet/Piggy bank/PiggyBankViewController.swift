//
//  PiggyBankViewController.swift
//  MobileWallet
//
//  Created Dominika Poleshyck on 9.11.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
// MARK: View -
protocol PiggyBankViewProtocol: AnyObject {
    func addElementToTableView(to indexPath: IndexPath)
    func removeElementFromTableView(to indexPath: IndexPath)
    func reloadTableView()
    func labelIsHidden()
    func labelIsNotHidden()
    func updateLabel(money: Int32, currentValue: Int32)
    func updateLabel(money: Double)
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
}

class PiggyBankViewController: UIViewController {
    @IBOutlet private weak var piggyBanklView: UIView!
    @IBOutlet private weak var piggyBankImageView: UIImageView!
    @IBOutlet private weak var savedMoney: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var listOfOperationLabel: UILabel!
    
    var presenter: PiggyBankPresenterProtocol = PiggyBankPresenter()
    private var intelligence: Intelligence?
    let tabbarVC = UITabBarController()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        presenter.view = self
        presenter.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PiggyBankCell", bundle: Bundle.main), forCellReuseIdentifier: "PiggyBankCell")
        tabbarVC.delegate = self
        DatabaseService.shared.entitiesFor(type: Intelligence.self, context: DatabaseService.shared.persistentContainer.mainContext) { intelligences in
            guard let intelligence = intelligences.first else {
                return
            }
            self.intelligence = intelligence
            self.savedMoney.text = String(intelligence.piggyBankLabel)
        }
    }
    
    func showAlert() {
        var textFieldText: String = ""
        let alertAddMoney = UIAlertController(title: "Add money", message: "Please, enter amount and press 'add' ", preferredStyle: .alert)
        alertAddMoney.addTextField { textField in
            textField.placeholder = "deposit money"
        }
        let alertAddMoneyAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let piggyBankSavedMoneyLabelText = alertAddMoney.textFields?.first?.text,
                  let piggyBankSavedMoneyLabelInt = Int(piggyBankSavedMoneyLabelText)else {
                return
            }
            self.presenter.addMoneyToPiggyBank(money: piggyBankSavedMoneyLabelInt)
        }
        alertAddMoney.addAction(alertAddMoneyAction)
        present(alertAddMoney, animated: true, completion: nil)
    
    }
    
    @IBAction private func addMoneyButtonPressed() {
        showAlert()
    }
}

extension PiggyBankViewController: PiggyBankViewProtocol {
    func addElementToTableView(to indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func removeElementFromTableView(to indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func updateLabel(money: Int32, currentValue: Int32) {
        savedMoney.text = String(money + currentValue)
    }
    
    func updateLabel(money: Double) {
        savedMoney.text = String(money)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func labelIsHidden() {
        listOfOperationLabel.isHidden = true
    }
    
    func labelIsNotHidden() {
        listOfOperationLabel.isHidden = false
    }
    
}

extension PiggyBankViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuation = UISwipeActionsConfiguration(actions: [UIContextualAction(
            style: .destructive,
            title: "Delete",
            handler: { _, _, _ in
                self.presenter.removeMoney(for: indexPath)
            }
        )
    ]
)
        return configuation
    }
}

extension PiggyBankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfElementsInTextArray()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PiggyBankCell", for: indexPath) as? PiggyBankCell else {
            return UITableViewCell()
        }
        cell.update(with: presenter.elementInTextArray(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension PiggyBankViewController: UITabBarControllerDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
