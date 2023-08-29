//
//  CurrencyEntity+CoreDataClass.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 28.07.23.
//
//

import Foundation
import CoreData

@objc(CurrencyEntity)
public class CurrencyEntity: NSManagedObject {
    
    public func resetAll() {
        if(coinTypes == nil) {
            print("Error while reset cause coinTypes is nil")
        } else {
            for coinType in coinTypes?.allObjects as! [CoinTypeEntity] {
                coinType.resetAll()
            }
            
        }
        
    }
}
