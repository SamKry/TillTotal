//
//  CoinDataLoader.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 23.07.23.
//

import SwiftUI
import CoreData

class CoinDataLoader{
    
    private static let context = CoreDataManager.instance.context
    
    static func loadTillOrCreate() -> TillEntity {
        let tillRepo = TillEntityReopsitory(container: CoreDataManager.instance.container)
        do{
            let firstTill = try tillRepo.getAll().first
            if(firstTill != nil) {
                print("Found Till Entity: \(firstTill?.name ?? "(no name defined)")")
                return firstTill!
            }
        } catch {
            print("error loading Tills from CoinDataLoader")
        }
        print("init a new Till")
        return CoinDataLoader.initTill()
    }
    
    static func initTill() -> TillEntity {
        print("init a new Till")
        let newTill = TillEntity(context: context)
        newTill.name = "default Till"
        newTill.cashStock = 2000
        newTill.refrenceTotal = 0
        newTill.id = UUID()
        newTill.currency = CoinDataLoader.initCHF(till: newTill)
        
        return newTill
    }
    
    private static func initCHF(till:TillEntity) -> CurrencyEntity {
        
        let newCurrency = CurrencyEntity(context: context)
        newCurrency.icon = "francsign.circle"
        newCurrency.name = "CHF"
        newCurrency.till = till
        
        
        let cashs = CoinDataLoader.initCoinType(id: 1, icon: "dollarsign.circle", isOther: false, name: "Münzen",
                                                coins: [
                                                    CoinDataLoader.initCoin(value: 5),
                                                    CoinDataLoader.initCoin(value: 2),
                                                    CoinDataLoader.initCoin(value: 1),
                                                    CoinDataLoader.initCoin(value: 0.50),
                                                    CoinDataLoader.initCoin(value: 0.20),
                                                    CoinDataLoader.initCoin(value: 0.10),
                                                    CoinDataLoader.initCoin(value: 0.05),
                                                ])
        let notes = CoinDataLoader.initCoinType(id: 2, icon: "banknote", isOther: false, name: "Noten",
                                                coins: [
                                                    CoinDataLoader.initCoin(value: 500),
                                                    CoinDataLoader.initCoin(value: 200),
                                                    CoinDataLoader.initCoin(value: 100),
                                                    CoinDataLoader.initCoin(value: 50),
                                                    CoinDataLoader.initCoin(value: 20),
                                                    CoinDataLoader.initCoin(value: 10),
                                                ])
        let rolls = CoinDataLoader.initCoinType(id: 3, icon: "cylinder.split.1x2", isOther: false, name: "Münzrollen",
                                                coins: [
                                                    CoinDataLoader.initCoin(value: 125),
                                                    CoinDataLoader.initCoin(value: 100),
                                                    CoinDataLoader.initCoin(value: 50),
                                                    CoinDataLoader.initCoin(value: 25),
                                                    CoinDataLoader.initCoin(value: 20),
                                                    CoinDataLoader.initCoin(value: 10),
                                                    CoinDataLoader.initCoin(value: 5),
                                                    CoinDataLoader.initCoin(value: 2.50),
                                                ])
        let other = CoinDataLoader.initCoinType(id: 4, icon: "plus.circle", isOther: true, name: "Andere",
                                                coins: [
                                                    CoinDataLoader.initCoin(value: 0),
                                                    CoinDataLoader.initCoin(value: 0),
                                                    CoinDataLoader.initCoin(value: 0)
                                                ])
        
        newCurrency.coinTypes = [cashs, notes, rolls, other]
        
        return newCurrency
    }
    
    private static func initCoinType(id:Int64, icon:String, isOther:Bool, name:String, coins:[CoinEntity]) -> CoinTypeEntity {
        
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
    
    static func initCoin(value:Double) -> CoinEntity {
        let newCoin: CoinEntity = CoinEntity(context: context)
        newCoin.value = value
        newCoin.number = 0
        return newCoin
    }
}
