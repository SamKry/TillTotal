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
    
    private let repository = CoinEntityReopsitory(container: CoreDataManager.instance.container)
    
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
//                do{
//                    for i in 3...self.coins.count-1{
//                        try self.repository.delete(entity: self.coins[i])
//                    }
//                } catch {
//                    print("Error while deleting coins")
//                }
//                self.coins.removeAll()
//                self.addOther()
//                self.addOther()
//                self.addOther()
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
        let sortedCoins = coinTypeEntity.coins?.sortedArray(using: [NSSortDescriptor(key: "value", ascending: false)])
        coins.removeAll()
        self.coins = sortedCoins as! [CoinEntity]
    }
    
    func save() {
        CoreDataManager.instance.saveData()
    }
}
