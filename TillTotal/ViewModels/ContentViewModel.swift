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
    
    @Published var coinTypes:[CoinTypeEntity]
    let icon:Image
    let name:String
    
    init(till:TillEntity, currency:CurrencyEntity) {
        self.till = till
        self.currency = currency
        self.coinTypes = till.currency?.coinTypes?.sortedArray(using: [NSSortDescriptor(key: "id", ascending: true)]) as! [CoinTypeEntity]
        self.icon = Image(currency.icon ?? "exclamationmark.questionmark")
        self.name = currency.name ?? "NoName"
    }
}
