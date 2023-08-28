//
//  ContentViewModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import SwiftUI

class ContentViewModel:ObservableObject {
    @Published var till:TillEntity
    @Published var currency:CurrencyEntity
    let tillRepo:TillEntityReopsitory = TillEntityReopsitory(container: CoreDataManager.instance.container)
    
    @Published var coinTypeVMs:[CoinTypeViewModel] = []
    
    @Published var coinTypes:[CoinTypeEntity]
    let icon:Image
    let name:String
    
    init(till:TillEntity, currency:CurrencyEntity) {
        self.till = till
        self.currency = currency
        self.coinTypes = till.currency?.coinTypes?.sortedArray(using: [NSSortDescriptor(key: "id", ascending: true)]) as! [CoinTypeEntity]
        self.icon = Image(currency.icon ?? "exclamationmark.questionmark")
        self.name = currency.name ?? "NoName"
        for coinType in coinTypes {
            coinTypeVMs.append(CoinTypeViewModel(coinTypeEntity: coinType))
        }
    }
    
    func reset(){
        currency.resetAll()
        reloadModel()
    }
    
    
    func reloadModel() {
        coinTypes.removeAll()
        self.coinTypes = till.currency?.coinTypes?.sortedArray(using: [NSSortDescriptor(key: "id", ascending: true)]) as? [CoinTypeEntity] ?? []
        coinTypeVMs.removeAll()
        for coinType in coinTypes {
            coinTypeVMs.append(CoinTypeViewModel(coinTypeEntity: coinType))
        }
    }
}
