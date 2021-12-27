//
//  RegistrationPresenter.swift
//  MobileWallet
//
//  Created Dominika Poleshyck on 9.11.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: Presenter -
protocol RegistrationPresenterProtocol {
    var view: RegistrationViewProtocol? { get set }
    func viewDidLoad()
    func addPhoto(new photo: Data)
    func changeName(name: String)
    func insertSalary(salary: Int)
    func insertCostOfTheDream(cost: Int)
    func insertNameOfTheDream(nameOfTheDream: String)
    func insertCountOfMounth(months: Int)
    func save()
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var view: RegistrationViewProtocol?
    
    private var name: String?
    private var photoData: Data?
    private var salary: Int?
    private var costOfTheDream: Int?
    private var nameOfTheDream: String?
    private var countOfMounth: Int?
    
    func viewDidLoad() {
    }
    
    func addPhoto(new photo: Data) {
        self.photoData = photo
        self.view?.downloadPickedView(photo: photo)
    }
    
    func changeName(name: String) {
        self.name = name
    }
    
    func insertSalary(salary: Int) {
        self.salary = salary
    }
    
    func insertCostOfTheDream(cost: Int) {
        self.costOfTheDream = cost
    }
    
    func insertNameOfTheDream(nameOfTheDream: String) {
        self.nameOfTheDream = nameOfTheDream
    }
    
    func insertCountOfMounth(months: Int) {
        self.countOfMounth = months
    }
    
    func averageDailyCostSave(moneyDay: Int) {
        
    }
    
    func save() {
        guard let name = name,
              let photoData = photoData,
              let salary = salary,
              let nameOfTheDream = nameOfTheDream,
              let costOfTheDream = costOfTheDream,
              let countOfMounth = countOfMounth
        else {
            self.view?.showAlert()
            return
        }
        
        DatabaseService.shared.insertEntityFor(
            type: Intelligence.self,
            context: DatabaseService.shared.persistentContainer.mainContext) { (information) in
                information.photoDreamCD = photoData
                information.nameOfOwnerCD = name
                information.nameOfTheDreamCD = nameOfTheDream
                information.salaryCD = Int32(salary)
                information.dreamCostCD = Int32(costOfTheDream)
                information.monthsCD = Int32(countOfMounth)
                information.moneyDay = Int32(self.averageDailyCosts())
                DatabaseService.shared.saveMain {
                    self.view?.showNextScreen()
                }
            }
    }
    
    func averageDailyCosts() -> Int {
        guard let earnings = salary else { return 0 }
        guard let priceOfDream = costOfTheDream else { return 0 }
        guard let countOfMounth = countOfMounth else { return 0 }
        let averageDailyCost = (earnings - (priceOfDream / countOfMounth)) / 31
        return averageDailyCost
    }
}
