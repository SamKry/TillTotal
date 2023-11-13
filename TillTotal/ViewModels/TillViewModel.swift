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
    
    private let id:UUID
    @Published var name:String
    
    // can be set via textfield must call updateLocalVariables() after update
    @Published var cashStock:Double{
        didSet{
            updateLocalVariables()
        }
    }
    @Published var refrenceTotal:Double{
        didSet{
            updateLocalVariables()
        }
    }
    
    // set by coinTypes and calculated by updateCoins()
    @Published var cashBrutto:Double = 0.0
    @Published var othersIs:Double = 0.0
    
    // Calculated by updateVariables()
    @Published var cashNetto:Double = 0.0
    @Published var diff:Double = 0.0
    
    init(tillEntity:TillEntity) {
        self.tillEntity = tillEntity
        self.currencyEntity = tillEntity.currency!
        self.cashStock = tillEntity.cashStock
        self.refrenceTotal = tillEntity.refrenceTotal
        self.name = tillEntity.name!
        self.id = tillEntity.id!
        refetchAndUpdateVariables()
    }    
    
    func refetchAndUpdateVariables() {
        updateCoins()
        updateLocalVariables()
    }
    
    func updateLocalVariables() {
        updateCash()
        updateDiff()
        save()
    }
    
    private func updateCoins(){
        othersIs = 0.0
        cashBrutto = 0.0
        for coinType in currencyEntity.coinTypes?.allObjects as! [CoinTypeEntity] {
            if(coinType.isOther){
                othersIs += coinType.getTotal()
            } else {
                cashBrutto += coinType.getTotal()
            }
        }
    }
    
    func updateCash(){
        cashNetto = cashBrutto - cashStock
    }
    
    func updateDiff() {
        diff = getTotal() - refrenceTotal
    }
    
    func getTotal() -> Double {
        return cashNetto + othersIs
    }
    
    func save() {
        tillEntity.refrenceTotal = refrenceTotal
        tillEntity.cashStock = cashStock
        CoreDataManager.instance.saveData()
    }
    
    func reset() {
        cashStock = 2000.0
        refrenceTotal = 0.0
        save()
    }
}
