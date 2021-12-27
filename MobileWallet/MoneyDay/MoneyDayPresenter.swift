//
//  MoneyDayPresenter.swift
//  MobileWallet
//
//  Created Dominika Poleshyck on 4.12.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation


// MARK: Presenter -
protocol MoneyDayPresenterProtocol {
    var view: MoneyDayViewProtocol? { get set }
    func viewDidLoad()
    func viewWillAppear()
    func numberOfElementsInTextArray() -> Int
    func elementInTextArray(for indexPath: IndexPath) -> IntelligenceMD
    func removeElementFromTableView(to indexPath: IndexPath)
}

class MoneyDayPresenter: MoneyDayPresenterProtocol {
    
    private var spentMoneyArray: [IntelligenceMD] = []
    weak var view: MoneyDayViewProtocol?
    
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        DatabaseService.shared.entitiesFor(
            type: IntelligenceMD.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: {
                savedMoney in
                self.spentMoneyArray = savedMoney
                self.view?.reloadTableView()
            }
        )
    }
    
    func removeElementFromTableView(to indexPath: IndexPath) {
        DatabaseService.shared.delete(spentMoneyArray[indexPath.row], context: DatabaseService.shared.persistentContainer.mainContext) { _ in
            self.spentMoneyArray.remove(at: indexPath.row)
            DatabaseService.shared.saveMain(nil)
            self.view?.removeElementFromTableView(to: indexPath)
        }
    }
    
    func numberOfElementsInTextArray() -> Int {
        return spentMoneyArray.count
    }
    
    func elementInTextArray(for indexPath: IndexPath) -> IntelligenceMD {
        return spentMoneyArray[indexPath.row]
    }
}

