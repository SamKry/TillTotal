//
//  CoinDataHelper.swift
//  TillTotalTests
//
//  Created by Samuel Kreyenbühl on 19.07.23.
//

import Foundation
import SwiftUI

struct CoinDataHelper {
    static func initEmptyCoinData() -> CoinData {
        return CoinData(
            coinTypes: [
                CoinData.CoinType(icon: Image(systemName: "dollarsign.circle"),
                                  currencies: [
                                    CoinData.Coin(value: 5, count: 0),
                                    CoinData.Coin(value: 2, count: 0),
                                    CoinData.Coin(value: 1, count: 0),
                                    CoinData.Coin(value: 0.50, count: 0),
                                    CoinData.Coin(value: 0.20, count: 0),
                                    CoinData.Coin(value: 0.10, count: 0),
                                    CoinData.Coin(value: 0.05, count: 0)
                                  ], title: "Münzen", color: .green),
                CoinData.CoinType(icon: Image(systemName: "banknote"),
                                  currencies: [
                                    CoinData.Coin(value: 500, count: 0),
                                    CoinData.Coin(value: 200, count: 0),
                                    CoinData.Coin(value: 100, count: 0),
                                    CoinData.Coin(value: 50, count: 0),
                                    CoinData.Coin(value: 20, count: 0),
                                    CoinData.Coin(value: 10, count: 0)
                                  ], title: "Noten", color: .blue),
                CoinData.CoinType(icon: Image(systemName: "cylinder.split.1x2"),
                                  currencies: [
                                    CoinData.Coin(value: 125, count: 0),
                                    CoinData.Coin(value: 100, count: 0),
                                    CoinData.Coin(value: 50, count: 0),
                                    CoinData.Coin(value: 25, count: 0),
                                    CoinData.Coin(value: 10, count: 0),
                                    CoinData.Coin(value: 5, count: 0),
                                    CoinData.Coin(value: 2.50, count: 0)
                                  ], title: "Münzrollen", color: .orange),
                CoinData.CoinType(icon: Image(systemName: "plus.circle"),
                                  currencies: [
                                    CoinData.Other(total: 0),
                                    CoinData.Other(total: 0)
                                  ], title: "Andere", color: .red)
            ]
        )
    }
}
