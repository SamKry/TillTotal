//
//  CoinViewModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import SwiftUI

class CoinViewModel:ObservableObject,Identifiable {
    private var coinEntity:CoinEntity
    var repository = CoinEntityReopsitory(container: CoreDataManager.instance.container)
    
    @Published var didAdd:Callback?
    @Published var didSubstract:Callback?
    @Published var didDelete:Callback?
    private var totalDidLastUpdate:Bool = true
    
    @Published var number:Int64 {
        didSet {
            totalDidLastUpdate = false
            calcTotal()
            save()
        }
    }
    
    @Published var value:Double {
        didSet {
            totalDidLastUpdate = false
            calcTotal()
            save()
        }
    }
    
    @Published var total:Double{
        didSet {
            // NOTE: Do not change self.number here! (will recall total.didSet())
            totalDidLastUpdate = true
            save()
        }
    }
    
    let icon:Image
    var isOther:Bool
    
    init(coinEntity: CoinEntity, isOther:Bool, didDelete:Callback?){
        self.coinEntity = coinEntity
        self.isOther = isOther
        self.didDelete = didDelete
        if(isOther){
            self.number = 1
            coinEntity.number = 1
        } else {
            self.number = coinEntity.number
        }
        self.value = coinEntity.value
        self.icon = Image(systemName: coinEntity.coinType?.icon ?? "exclamationmark.triangle")
        self.total = 0
        calcTotal()
        if(isOther) {
            didSubstract = delete
        } else {
            self.didAdd = add
            self.didSubstract = substract
        }
        save()
    }
    
    func calcTotal() {
        let intNumber = Int64(Double(number)+0.5)
        let newTotal = value*Double(intNumber)
        self.total = newTotal
    }
    
    func calcNumber(){
        let numbDouble = (total/value)+0.5
        if( numbDouble.isNaN || numbDouble.isInfinite) {
            print("Error in CoinView with numDouble Nan or infinite. Setting number to 0 ")
            number = 0
        } else {
            number = Int64((total/value)+0.5)
        }
    }
    
    func refreshValues(){
        if(totalDidLastUpdate) {
            calcNumber()
            calcTotal()
        }
        else {
            calcTotal()
            calcNumber()
        }
    }
    
    func save() {
        coinEntity.value = value
        coinEntity.number = number
        
        CoreDataManager.instance.saveData()
    }
    
    func delete() {
        if(isOther){
            do {
                try repository.delete(entity: coinEntity)
            } catch {
                print("Error while deleting coinEntitiy")
            }
        }
        CoreDataManager.instance.saveDataNow()
        if(didDelete != nil){
            didDelete!()
        }
        HapticFeedback.error()
    }
    
    func substract() {
        if number > 0{
            number-=1
            HapticFeedback.ok()
        }
    }
    
    func add() {
        number+=1
        HapticFeedback.ok()
        
    }
    
    func reloadModel() {
        if(isOther){
            coinEntity.number = 1
            self.number = coinEntity.number
            self.value = coinEntity.value
        } else {
            self.number = coinEntity.number
        }
        calcTotal()
    }
    
}
