//
//  CoinTypeViewModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import CoreData
import SwiftUI

class CoinTypeViewModel:ObservableObject, Identifiable {
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
        if(isOther){
            coinTypeEntity.didReset = {
                self.reloadModel()
            }
        }
    }
    
    func addOther() {
        let newCoin = CoinDataLoader.initCoin(value: 0)
        newCoin.coinType = coinTypeEntity
        coins.append(newCoin)
        save()
    }
    
    func reloadModel() {
        CoreDataManager.instance.saveDataNow()
        coins.removeAll()
        let sortedCoins = coinTypeEntity.coins?.sortedArray(using: [NSSortDescriptor(key: "value", ascending: false)])
        if(sortedCoins == nil){
            print("Sorted coins is nil!")
            return
        }
        self.coins = sortedCoins as! [CoinEntity]
    }
    func save() {
        CoreDataManager.instance.saveData()
    }
}
