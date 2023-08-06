//
//  CoinViewModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import Foundation


class CoinViewModel:ObservableObject {
    private var coin:CoinEntity
    
    @Published var number:Int64
    @Published var value:Double
    
    init(coin: CoinEntity) {
        self.coin = coin
        self.number = coin.number
        self.value = coin.value
    }
}
