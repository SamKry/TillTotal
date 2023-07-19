//
//  TillStockModel.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 15.07.23.
//
import SwiftUI

protocol Currency {
    func getTotal() -> Double
}

class CoinData: ObservableObject {
    @Published var coinTypes = [CoinType]()

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

        public func setAmount(fromTotal total: Double) {
            self.count = Int((total / value) + 0.5)
        }
    }

    class Other: Currency {
        var total: Double

        init(total: Double) {
            self.total = total
        }

        func getTotal() -> Double {
            return total
        }
    }

    init(coinTypes: [CoinType]) {
        self.coinTypes = coinTypes
    }
}
