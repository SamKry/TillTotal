//
//  TillEntity+CoreDataProperties.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 24.07.23.
//
//

import Foundation
import CoreData


extension TillEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TillEntity> {
        return NSFetchRequest<TillEntity>(entityName: "TillEntity")
    }

    @NSManaged public var cashStock: Double
    @NSManaged public var totalSoll: Double

}

extension TillEntity : Identifiable {

}
