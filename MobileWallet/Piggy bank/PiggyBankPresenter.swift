//
//  PiggyBankPresenter.swift
//  MobileWallet
//
//  Created Dominika Poleshyck on 9.11.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation

// MARK: Presenter -
protocol PiggyBankPresenterProtocol {
	var view: PiggyBankViewProtocol? { get set }
    func viewDidLoad()
    func removeMoney(for indexPath: IndexPath)
    func numberOfElementsInTextArray() -> Int
    func elementInTextArray(for indexPath: IndexPath) -> String
    func addMoneyToPiggyBank(money: Int)
}

class PiggyBankPresenter: PiggyBankPresenterProtocol {
    private var savedMoneyArray: [SavedMoney] = []
    weak var view: PiggyBankViewProtocol?
    private var moneyForPiggyBank: Int?
    private var piggyBankCell = PiggyBankCell()
    func viewDidLoad() {
        DatabaseService.shared.entitiesFor(
            type: SavedMoney.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: {
                savedMoney in
                self.savedMoneyArray = savedMoney
                self.calculateCash()
                self.view?.reloadTableView()
                if self.savedMoneyArray.isEmpty {
                    self.view?.labelIsNotHidden()
                } else {
                    self.view?.labelIsHidden()
                }
            }
        )
    }
    
    private func calculateCash() {
        let cashes = savedMoneyArray.map { money in
            return money.amount
        }
        let generalCash = cashes.joined()
        view?.updateLabel(money: generalCash)
    }
    
    func addMoneyToPiggyBank(money: Int) {
        DatabaseService.shared.insertEntityFor(type: SavedMoney.self, context: DatabaseService.shared.persistentContainer.mainContext) { savedMoney in
            savedMoney.date = Date()
            savedMoney.amount = Double(money)
            self.savedMoneyArray.append(savedMoney)
            self.calculateCash()
            DatabaseService.shared.saveMain({
                self.view?.reloadTableView()
//                addElementToTableView(to: IndexPath(row: self.numberOfElementsInTextArray(), section: 0))
                self.view?.labelIsHidden()
            })
            
        }
    }
        
    func removeMoney(for indexPath: IndexPath) {
        DatabaseService.shared.delete(savedMoneyArray[indexPath.row], context: DatabaseService.shared.persistentContainer.mainContext) { _ in
            self.savedMoneyArray.remove(at: indexPath.row)
            self.calculateCash()
            DatabaseService.shared.saveMain(nil)
            self.view?.removeElementFromTableView(to: indexPath)
        }
    }
    
    func numberOfElementsInTextArray() -> Int {
        return savedMoneyArray.count
    }
    
    func elementInTextArray(for indexPath: IndexPath) -> String {
            return "\(savedMoneyArray[indexPath.row].amount)"
        }
}

extension Array where Element == Double {
    func joined() -> Double {
        var summa: Double = 0
        self.forEach { element in
            summa += element
        }
        return summa
    }
}
