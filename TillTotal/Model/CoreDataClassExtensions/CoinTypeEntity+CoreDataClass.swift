//
//  CoinTypeEntity+CoreDataClass.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 24.07.23.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(CoinTypeEntity)
public class CoinTypeEntity: NSManagedObject {
    
    func getTotal() -> Double {
        var total:Double = 0.0
        for coin in coins?.allObjects as! [CoinEntity] {
            total += coin.getTotal()
        }
        return total
    }
}
