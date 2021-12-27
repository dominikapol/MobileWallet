//
//  Intelligence+CoreDataClass.swift
//  
//
//  Created by Dominika Poleshyck on 11.12.21.
//
//

import Foundation
import CoreData

@objc(Intelligence)
public class Intelligence: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Intelligence> {
        return NSFetchRequest<Intelligence>(entityName: "Intelligence")
    }

    @NSManaged public var dreamCostCD: Int32
    @NSManaged public var moneyDay: Int32
    @NSManaged public var monthsCD: Int32
    @NSManaged public var nameOfOwnerCD: String?
    @NSManaged public var nameOfTheDreamCD: String?
    @NSManaged public var photoDreamCD: Data?
    @NSManaged public var piggyBankCells: String?
    @NSManaged public var piggyBankLabel: Int32
    @NSManaged public var salaryCD: Int32
}
