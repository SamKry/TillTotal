//
//  SettingsViewModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 17.08.23.
//

import Foundation

class TillViewModel:ObservableObject {
    
    @Published var tillEntity:TillEntity
    private let currencyEntity:CurrencyEntity
    
    @Published var cashStock:Double {
        didSet {
            tillEntity.cashStock = cashStock
            updateVariables()
            save()
        }
    }
    @Published var refrenceTotal:Double{
        didSet {
            tillEntity.refrenceTotal = refrenceTotal
            updateDiff()
            save()
        }
    }
    
    private let id:UUID
    @Published var name:String
    
    @Published var cashIs:Double = 0.0
    @Published var othersIs:Double = 0.0
    
    @Published var diff:Double = 0.0
    
    init(tillEntity:TillEntity) {
        self.tillEntity = tillEntity
        self.currencyEntity = tillEntity.currency!
        self.cashStock = tillEntity.cashStock
        self.refrenceTotal = tillEntity.refrenceTotal
        self.name = tillEntity.name!
        self.id = tillEntity.id!
        updateVariables()
    }    
    
    func updateVariables() {
        updateCoins()
        updateDiff()
        save()
    }
    
    func updateDiff() {
        diff = getTotal() - refrenceTotal
    }
    
    private func updateCoins(){
        othersIs = 0.0
        cashIs = -cashStock
        for coinType in currencyEntity.coinTypes?.allObjects as! [CoinTypeEntity] {
            if(coinType.isOther){
                othersIs += coinType.getTotal()
            } else {
                cashIs += coinType.getTotal()
            }
        }
    }
    
    func getTotal() -> Double {
        return cashIs + othersIs
    }
    
    func save() {
        tillEntity.refrenceTotal = refrenceTotal
        tillEntity.cashStock = cashStock
        CoreDataManager.instance.saveData()
    }
    
    func reset() {
        cashStock = 2000
        refrenceTotal = 0.0
        CoreDataManager.instance.saveData()
    }
}
