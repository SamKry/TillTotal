//
//  CoinViewModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import SwiftUI

class CoinViewModel:ObservableObject {
    private var coinEntity:CoinEntity
    var repository = CoinEntityReopsitory(container: CoreDataManager.instance.container)
    
    @Published var didAdd:Callback?
    @Published var didSubstract:Callback?
    @Published var didDelete:Callback?
    
    @Published var number:Int64 {
        didSet {
            save()
        }
    }
    @Published var value:Double {
        didSet {
            save()
        }
    }
    
    @Published var total:Double = 0 {
        didSet {
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
        
        if(isOther) {
            didSubstract = delete
        } else {
            self.didAdd = add
            self.didSubstract = substract
        }
        save()
    }
    
    func calcTotal(){
        number = Int64(Double(number)+0.5)
        total = value*Double(number)
    }
    
    func calcNumber(){
        let numbDouble = (total/value)+0.5
        if( numbDouble.isNaN || numbDouble.isInfinite) {
            print("Error in CoinView with numDouble Nan or infinite. Setting number to 0 ")
            number = 0
        } else {
            number = Int64((total/value)+0.5)
        }
        calcTotal()
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
