//
//  CoinDataTests.swift
//  TillTotalTests
//
//  Created by Samuel Kreyenbühl on 19.07.23.
//

import XCTest
import SwiftUI

@testable import TillTotal// Replace "YourAppName" with your actual app name

class CoinDataTests: XCTestCase {
    var fullCoinDataCHF: CoinData!
    
    override func setUp() {
        super.setUp()
        self.fullCoinDataCHF = CoinDataHelper.initEmptyCoinData()
    }
    
    func testSetAmountFromTotal() {
        // Create a test coin
        let testCoin = CoinData.Coin(value: 2, count: 0)
        
        testCoin.setAmount(fromTotal: 22.75)
        XCTAssertEqual(testCoin.count, 11)
        
        testCoin.setAmount(fromTotal: 10.9)
        XCTAssertEqual(testCoin.count, 5)
        
        testCoin.setAmount(fromTotal: 0.95)
        XCTAssertEqual(testCoin.count, 0)
        
        testCoin.setAmount(fromTotal: 1.0)
        XCTAssertEqual(testCoin.count, 1)
        
        testCoin.setAmount(fromTotal: 1.1)
        XCTAssertEqual(testCoin.count, 1)
        
    }
    
    func testCoinTypeInitialization() {
        // Create a test coin
        let testCoin = CoinData.Coin(value: 0.25, count: 0)
        
        // Create a test coin type
        let testCoinType = CoinData.CoinType(icon: Image("coin_icon"), currencies: [testCoin], title: "Quarter", color: .blue)
        
        // Test the properties of the test coin type
        XCTAssertEqual(testCoinType.title, "Quarter")
        XCTAssertEqual(testCoinType.color, .blue)
        XCTAssertEqual(testCoinType.currencies.count, 1)
        
        // Since we have a protocol now, we need to cast the currency as CoinData.Coin
        guard let coin = testCoinType.currencies[0] as? CoinData.Coin else {
            XCTFail("Currency is not of type CoinData.Coin")
            return
        }
        
        XCTAssertEqual(coin.value, 0.25)
        XCTAssertEqual(coin.count, 0)
        
    }
    
    func testCoinDataInitialization() {
        // Test case 1: Empty coin types array
        let emptyCoinData = CoinData(coinTypes: [])
        XCTAssertTrue(emptyCoinData.coinTypes.isEmpty)
        
        // Test case 2: Single coin type with a single coin
        let quarter = CoinData.Coin(value: 0.25, count: 0)
        let quarterType = CoinData.CoinType(icon: Image("quarter_icon"), currencies: [quarter], title: "Quarter", color: .green)
        let singleCoinTypeData = CoinData(coinTypes: [quarterType])
        XCTAssertEqual(singleCoinTypeData.coinTypes.count, 1)
        XCTAssertEqual(singleCoinTypeData.coinTypes.first?.title, "Quarter")
        XCTAssertEqual(singleCoinTypeData.coinTypes.first?.currencies.count, 1)
        XCTAssertEqual((singleCoinTypeData.coinTypes.first?.currencies.first as? CoinData.Coin)?.value, 0.25)
        
        // Test case 3: Multiple coin types with multiple coins
        let nickel = CoinData.Coin(value: 0.05, count: 0)
        let dime = CoinData.Coin(value: 0.10, count: 0)
        
        let nickelType = CoinData.CoinType(icon: Image("nickel_icon"), currencies: [nickel], title: "Nickel", color: .orange)
        let dimeType = CoinData.CoinType(icon: Image("dime_icon"), currencies: [dime], title: "Dime", color: .purple)
        
        let multipleCoinTypeData = CoinData(coinTypes: [quarterType, nickelType, dimeType])
        XCTAssertEqual(multipleCoinTypeData.coinTypes.count, 3)
        XCTAssertEqual(multipleCoinTypeData.coinTypes[0].title, "Quarter")
        XCTAssertEqual(multipleCoinTypeData.coinTypes[1].title, "Nickel")
        XCTAssertEqual(multipleCoinTypeData.coinTypes[2].title, "Dime")
        XCTAssertEqual(multipleCoinTypeData.coinTypes[0].currencies.count, 1)
        XCTAssertEqual(multipleCoinTypeData.coinTypes[1].currencies.count, 1)
        XCTAssertEqual(multipleCoinTypeData.coinTypes[2].currencies.count, 1)
        XCTAssertEqual((multipleCoinTypeData.coinTypes[0].currencies.first as? CoinData.Coin)?.value, 0.25)
        XCTAssertEqual((multipleCoinTypeData.coinTypes[1].currencies.first as? CoinData.Coin)?.value, 0.05)
        XCTAssertEqual((multipleCoinTypeData.coinTypes[2].currencies.first as? CoinData.Coin)?.value, 0.10)
    }
    
    
}
