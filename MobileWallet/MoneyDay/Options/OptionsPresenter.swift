//
//  OptionsPresenter.swift
//  MobileWallet
//
//  Created by Dominika Poleshyck on 15.12.21.
//

import Foundation

protocol OptionsPresenterProtocol {
    var view: OptionsView? { get set }
    func viewDidLoad()
    func insertDatePresenter(date: String)
    func insertTimerecipientsAccount(recipientsAccount: String)
    func insertTypePresenter(type: String)
    func insertAmountPresenter(amount: String)
    func save()
}

class OptionsPresenter: OptionsPresenterProtocol {
    
    weak var view: OptionsView?
    private var type: String?
    private var amount: String?
    private var date: String?
    private var recipientsAccount: String?
    
    func viewDidLoad() {
        
    }
    
    func insertDatePresenter(date: String) {
        self.date = date
    }
    
    func insertTimerecipientsAccount(recipientsAccount: String) {
        self.recipientsAccount = recipientsAccount
    }
    
    func insertTypePresenter(type: String) {
        self.type = type
    }
    
    func insertAmountPresenter(amount: String) {
        self.amount = amount
    }
    
    func save() {
        DatabaseService.shared.insertEntityFor(type: IntelligenceMD.self, context: DatabaseService.shared.persistentContainer.mainContext) { information in
            information.type = self.type
            information.date = self.date
            information.recipientsAccount = self.recipientsAccount
            information.amountOfSpent = self.amount
            DatabaseService.shared.saveMain(nil)
        }
    }
}
