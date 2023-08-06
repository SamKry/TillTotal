//
//  ContentViewModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import CoreData

class ContentViewModel:ObservableObject {
    @Published var till:TillEntity?
    private var tillEntityReopsitory:TillEntityReopsitory
    
   @Published var currency:CurrencyEntity?
    private var currencyEntityReopsitory:CurrencyEntityReopsitory
    
    var container:NSPersistentContainer
    
    init(container:NSPersistentContainer) {
        self.container = container
        self.tillEntityReopsitory = TillEntityReopsitory(container: container)
        self.currencyEntityReopsitory = CurrencyEntityReopsitory(container: container)
        do{
            self.till = try tillEntityReopsitory.getAll().first
            print("Till name: \(till?.name ?? "none")")
            print("cashStock: \(till?.id)")
        } catch{
            print("error loading till")
        }
    }
    
    func initTill(){
//        CoinDataLoader.initTill(context: container.viewContext)
//        TillEntityReopsitory.saveContext()
    }
    
}
