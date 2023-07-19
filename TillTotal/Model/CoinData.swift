//
//  TillStockModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 15.07.23.
//
import SwiftUI

protocol Currency {
    func getTotal() -> Double
    func reset()
}

class CoinData: ObservableObject {
    @Published var coinTypes = [CoinType]()
    
    init(coinTypes: [CoinType]) {
        self.coinTypes = coinTypes
    }
    
    class CoinType {
        var icon: Image
        var currencies: [Currency]
        var title: String
        var color: Color
        
        init(icon: Image, currencies: [Currency], title: String, color: Color) {
            self.icon = icon
            self.currencies = currencies
            self.title = title
            self.color = color
        }
        
        func getTotal() -> Double {
            var total:Double = 0.0
            for currency in currencies {
                total += currency.getTotal()
            }
            return total
        }
        
        func reset(){
            for currency in currencies {
                currency.reset()
            }
        }
    }
    
    func reset(){
        for coinType in coinTypes {
            for currency in coinType.currencies {
                currency.reset()
            }
        }
    }
    
    func getTotal() -> Double {
        var total:Double = 0.0
        for coinType in coinTypes {
            for currency in coinType.currencies {
                total += currency.getTotal()
            }
        }
        return total
    }
    
    class Coin: Currency {
        
        var value: Double
        var count: Int
        
        init(value: Double, count: Int) {
            self.value = value
            self.count = count
        }
        
        func getTotal() -> Double {
            return value * Double(count)
        }
        
        func reset() {
            count = 0
        }
        
        public func setAmount(fromTotal total: Double) {
            self.count = Int((total / value) + 0.5)
        }
    }
    
    class Other: Currency {
        func reset() {
            total = 0.0
        }
        
        var total: Double
        
        init(total: Double) {
            self.total = total
        }
        
        func getTotal() -> Double {
            return total
        }
    }
}
