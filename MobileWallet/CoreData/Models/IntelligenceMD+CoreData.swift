//
//  IntelligenceMD+CoreDataClass.swift
//  
//
//  Created by Dominika Poleshyck on 15.12.21.
//
//

import Foundation
import CoreData

@objc(IntelligenceMD)
public class IntelligenceMD: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<IntelligenceMD> {
        return NSFetchRequest<IntelligenceMD>(entityName: "IntelligenceMD")
    }

    @NSManaged public var date: String?
    @NSManaged public var recipientsAccount: String?
    @NSManaged public var type: String?
    @NSManaged public var amountOfSpent: String?

}
