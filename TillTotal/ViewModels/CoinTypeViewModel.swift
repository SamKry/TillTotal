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
    
    private var coins:[CoinEntity] = []
    @Published var coinVMs:[CoinViewModel] = []
    let icon:Image
    let isOther:Bool
    let name:String
    
    init(coinTypeEntity:CoinTypeEntity) {
        self.coinTypeEntity = coinTypeEntity
        
        self.coins = coinTypeEntity.coins?.sortedArray(using: [NSSortDescriptor(key: "value", ascending: false)]) as! [CoinEntity]
        
        self.icon = Image(systemName: coinTypeEntity.icon ?? "exclamationmark.questionmark")
        self.isOther = coinTypeEntity.isOther
        self.name = coinTypeEntity.name ?? "NoName"
        reloadVMs()        
        if(isOther){
            coinTypeEntity.didReset = {
                self.reloadModel()
            }
        }
    }
    
    func reloadVMs(){
        coinVMs.removeAll()
        for coin in coins {
            coinVMs.append(
                CoinViewModel(
                    coinEntity: coin,
                    isOther: isOther,
                    didDelete: reloadModel))
        }
    }
    
    func addOther() {
        let newCoin = CoinDataLoader.initCoin(value: 0)
        newCoin.coinType = coinTypeEntity
        coins.append(newCoin)
        coinVMs.append(CoinViewModel(coinEntity: newCoin, isOther: isOther, didDelete: reloadModel))
        save()
        HapticFeedback.ok()
    }
    
    func revalidateAll(){
        if(!isOther){
            for coinVM in coinVMs {
                coinVM.refreshValues()
            }
        }
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
        reloadVMs()
    }
    
    func save() {
        CoreDataManager.instance.saveData()
    }
}
