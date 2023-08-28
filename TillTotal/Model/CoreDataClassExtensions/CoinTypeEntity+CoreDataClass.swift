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
    
    var didReset:Callback?
    
    public func getTotal() -> Double {
        var total:Double = 0.0
        for coin in coins?.allObjects as! [CoinEntity] {
            total += coin.getTotal()
        }
        return total
    }
    
    public func resetAll() {
        
        let allCoins = coins?.allObjects as? [CoinEntity] ?? []
        
        
        for coin in allCoins {
            if(isOther) {
                coin.value = 0
            } else {
                coin.number = 0
            }
        }
        if(didReset != nil) {
            didReset!()
        }
    }
}
