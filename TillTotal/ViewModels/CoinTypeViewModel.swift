//
//  CoinTypeViewModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import CoreData
import SwiftUI

class CoinTypeViewModel:ObservableObject {
    private var coinTypeEntity:CoinTypeEntity
    
    @Published var coins:[CoinEntity] = []
    let icon:Image
    let isOther:Bool
    let name:String
    
    init(coinTypeEntity:CoinTypeEntity) {
        self.coinTypeEntity = coinTypeEntity
        
        self.coins = coinTypeEntity.coins?.sortedArray(using: [NSSortDescriptor(key: "value", ascending: false)]) as! [CoinEntity]
        self.icon = Image(systemName: coinTypeEntity.icon ?? "exclamationmark.questionmark")
        self.isOther = coinTypeEntity.isOther
        self.name = coinTypeEntity.name ?? "NoName"
    }

    func addOther() {
        print("Before: \(coins.count)")
        let newCoin = CoinDataLoader.initCoin(value: 0)
        newCoin.coinType = coinTypeEntity
        coins.append(newCoin)
        print("After: \(coins.count)")
        save()
    }
    
    func save() {
        CoreDataManager.instance.saveData()
    }
    
    func reset() {
        for coin in coins {
            if (isOther) {
                coin.value = 0.0
                coin.number = 1
            } else {
                coin.number = 0
            }
        }
    }
}
