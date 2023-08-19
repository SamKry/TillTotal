//
//  CoinViewModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import SwiftUI

class CoinViewModel:ObservableObject {
    private var coinEntity:CoinEntity
    
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
    
    let icon:Image
    var isOther:Bool
    let superVM:CoinTypeViewModel
    
    init(coinEntity: CoinEntity, superVM:CoinTypeViewModel) {
        self.coinEntity = coinEntity
        self.isOther = coinEntity.coinType?.isOther ?? false
        if(isOther){
            self.number = 1
            coinEntity.number = 1
        } else {
            self.number = coinEntity.number
        }
        self.value = coinEntity.value
        self.icon = Image(systemName: coinEntity.coinType?.icon ?? "exclamationmark.triangle")
        self.superVM = superVM
        save()
    }
    
    private var debounceTimer: Timer?
    
    func save() {
        coinEntity.value = value
        coinEntity.number = number
        debounceTimer?.invalidate() // Invalidate the existing timer
        
        // Create a new timer that delays the saveData() call
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
            self?.debouncedSaveData()
        }
    }
    
    private func debouncedSaveData() {
        CoreDataManager.instance.saveData()
    }
}
