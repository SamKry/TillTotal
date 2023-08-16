//
//  CoinDataLoader.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 23.07.23.
//

import SwiftUI
import CoreData

class CoinDataLoader{
    static func initTill(context: NSManagedObjectContext) {
        let newTill = TillEntity(context: context)
        newTill.id = UUID()
        newTill.name = "Test Till"
        newTill.cashStock = 123.456
        newTill.refrenceTotal = 2023.8
        let newCurrency = CurrencyEntity(context: context)
        newTill.currency = newCurrency
        newCurrency.name = "new TestCurrency"
        newCurrency.id = 1
        
        let newCoinType1 = CoinTypeEntity(context: context)
        let newCoinType2 = CoinTypeEntity(context: context)
        let newCoinType3 = CoinTypeEntity(context: context)
        
        newCurrency.coinTypes = [newCoinType1, newCoinType2, newCoinType3]
        newCoinType1.id = 1
        newCoinType2.id = 2
        newCoinType3.id = 3
        newCoinType1.name = "Test CoinType1"
        newCoinType2.name = "Test CoinType2"
        newCoinType3.name = "Test CoinType3"
        newCoinType1.coins = [
            CoinEntity(context: context)
                .value = 1.0,
            CoinEntity(context: context)
                .value = 2.0,
            CoinEntity(context: context)
                .value = 3.0,
            CoinEntity(context: context)
                .value = 4.0,
            CoinEntity(context: context)
                .value = 5.0,
            CoinEntity(context: context)
                .value = 6.0
        ]
        
        newCoinType2.coins = [
            CoinEntity(context: context)
                .value = 10.0,
            CoinEntity(context: context)
                .value = 20.0,
            CoinEntity(context: context)
                .value = 30.0,
            CoinEntity(context: context)
                .value = 40.0,
            CoinEntity(context: context)
                .value = 50.0,
            CoinEntity(context: context)
                .value = 60.0
        ]
        
        newCoinType3.coins = [
            CoinEntity(context: context)
                .value = 11.0,
            CoinEntity(context: context)
                .value = 12.0,
            CoinEntity(context: context)
                .value = 13.0,
            CoinEntity(context: context)
                .value = 14.0,
            CoinEntity(context: context)
                .value = 15.0,
            CoinEntity(context: context)
                .value = 16.0
        ]
        
        //        return newTill
    }
    
    static func initCoin(value:Double) -> CoinEntity {
        let context = CoreDataManager.instance.context
        let newCoin: CoinEntity = CoinEntity(context: context)
        newCoin.value = value
        //        newCoin.isOther = isOther
        newCoin.number = 0
        return newCoin
    }
    
    static func initCoinType(id:Int64, icon:String, isOther:Bool, name:String, coins:[CoinEntity]) -> CoinTypeEntity {
        let context = CoreDataManager.instance.context
        
        let newCoinType = CoinTypeEntity(context: context)
        newCoinType.icon = icon
        newCoinType.id = id
        newCoinType.isOther = isOther
        newCoinType.name = name
        for coin in coins {
            coin.coinType = newCoinType
        }
        return newCoinType
    }
}
