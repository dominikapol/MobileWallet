//
//  MajorScreenPresenter.swift
//  MobileWallet
//
//  Created Dominika Poleshyck on 9.11.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: Presenter -
protocol MajorScreenPresenterProtocol {
    var view: MajorScreenViewProtocol? { get set }
    func viewDidLoad()
    func numberOfCurrency() -> Int
    func currency(for indexPath: IndexPath) -> String?
    func getPrice(url: String, param: [String: String])
    func updatePrices(json: JSON)
}

class MajorScreenPresenter: MajorScreenPresenterProtocol {
    private var intelligence: Intelligence?
    private var currencyArray: [String] = []
    weak var view: MajorScreenViewProtocol?
    let currencyURL = "http://data.fixer.io/api/latest"
    let key = "9d717098e07bf87eaff033cc14b848af"
    let base = "EUR"
    let symbols = "BYN, USD, RUB, GBP"
    
    func viewDidLoad() {
        let param = ["access_key": key,
                     "base": base,
                     "symbols": symbols]
        DatabaseService.shared.entitiesFor(
            type: Intelligence.self,
            context: DatabaseService.shared.persistentContainer.mainContext) { intelligences in
                guard let intelligence = intelligences.first else {
                    return
                }
                self.intelligence = intelligence
                self.view?.updateButtonsProgress(
                    firstRingProgress: Double(Int(intelligence.salaryCD)).progress(),
                    secondRingProgress: Double(Int(intelligence.moneyDay)).progress(),
                    thirdRingProgress: Double(Int(intelligence.dreamCostCD)).progress()
                )
            }
        getPrice(url: currencyURL, param: param)
    }
    
    func getPrice(url: String, param: [String: String]) {
        AF.request(url,method: .get, parameters: param).responseJSON { responce in
            print(responce)
            switch responce.result {
            case .success(let value):
                let json = JSON(value)
                self.updatePrices(json: json)
            case .failure(let error):
                print(error)
            }
        }
        self.view?.reloadData()
    }
    
    func updatePrices(json: JSON) {
        for (name, price) in json["rates"].dictionaryValue {
            let curr = ("\(name)     \(price)")
            currencyArray.append(curr)
        }
        self.view?.reloadData()
    }
    
    func numberOfCurrency() -> Int {
        return currencyArray.count
    }
    
    func currency(for indexPath: IndexPath) -> String? {
        return currencyArray[indexPath.row]
    }
}

private extension Double {
    func progress() -> Double {
        let doubleValue = self / pow(10, Double(Int.digitCount(number: Int(self))))
        return doubleValue - 0.01
    }
}

private extension Int {
    static func digitCount(number: Int) -> Int {
        if number < 10 && number >= 0 || number > -10 && number < 0 {
            return 1
        } else {
            return 1 + digitCount(number: number/10)
        }
    }
}
