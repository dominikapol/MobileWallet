//
//  SavedMoney+CoreDataClass.swift
//  
//
//  Created by Dominika Poleshyck on 13.12.21.
//
//

import Foundation
import CoreData

@objc(SavedMoney)
public class SavedMoney: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedMoney> {
        return NSFetchRequest<SavedMoney>(entityName: "SavedMoney")
    }

    @NSManaged public var date: Date?
    @NSManaged public var amount: Double
}
