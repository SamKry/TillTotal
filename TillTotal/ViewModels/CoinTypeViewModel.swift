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
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    let repository:CoinEntityReopsitory
    
    @Published var total:Double // TODO: does not update automatically
    
    
    
    @Published var coins:[CoinEntity] = []
    let icon:Image
    let isOther:Bool
    let name:String
    
    init(coinTypeEntity:CoinTypeEntity) {
        self.coinTypeEntity = coinTypeEntity
        self.container = CoreDataManager.instance.container
        self.context = CoreDataManager.instance.context
        self.repository = CoinEntityReopsitory(container: container)
        
        self.coins = coinTypeEntity.coins?.sortedArray(using: [NSSortDescriptor(key: "value", ascending: false)]) as! [CoinEntity]
        self.icon = Image(systemName: coinTypeEntity.icon ?? "exclamationmark.questionmark")
        self.isOther = coinTypeEntity.isOther
        self.name = coinTypeEntity.name ?? "NoName"
        self.total = 0.0
        updateTotal()
    }

    func updateTotal() {
        self.total = coinTypeEntity.getTotal()
    }
    
}
