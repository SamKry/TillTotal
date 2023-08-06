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
//    var fullCoinDataCHF: CoinData!
//    
//    override func setUp() {
//        super.setUp()
//        self.fullCoinDataCHF = CoinDataHelper.initEmptyCoinData()
//    }
//    
//    func testSetAmountFromTotal() {
//        // Create a test coin
//        let testCoin = CoinData.Coin(value: 2, count: 0)
//        
//        testCoin.setAmount(fromTotal: 22.75)
//        XCTAssertEqual(testCoin.count, 11)
//        
//        testCoin.setAmount(fromTotal: 10.9)
//        XCTAssertEqual(testCoin.count, 5)
//        
//        testCoin.setAmount(fromTotal: 0.95)
//        XCTAssertEqual(testCoin.count, 0)
//        
//        testCoin.setAmount(fromTotal: 1.0)
//        XCTAssertEqual(testCoin.count, 1)
//        
//        testCoin.setAmount(fromTotal: 1.1)
//        XCTAssertEqual(testCoin.count, 1)
//        
//    }
//    
//    func testCoinTypeInitialization() {
//        // Create a test coin
//        let testCoin = CoinData.Coin(value: 0.25, count: 0)
//        
//        // Create a test coin type
//        let testCoinType = CoinData.CoinType(icon: Image("coin_icon"), currencies: [testCoin], title: "Quarter", color: .blue)
//        
//        // Test the properties of the test coin type
//        XCTAssertEqual(testCoinType.title, "Quarter")
//        XCTAssertEqual(testCoinType.color, .blue)
//        XCTAssertEqual(testCoinType.currencies.count, 1)
//        
//        // Since we have a protocol now, we need to cast the currency as CoinData.Coin
//        guard let coin = testCoinType.currencies[0] as? CoinData.Coin else {
//            XCTFail("Currency is not of type CoinData.Coin")
//            return
//        }
//        
//        XCTAssertEqual(coin.value, 0.25)
//        XCTAssertEqual(coin.count, 0)
//        
//    }
//    
//    func testCoinDataInitialization() {
//        // Test case 1: Empty coin types array
//        let emptyCoinData = CoinData(coinTypes: [])
//        XCTAssertTrue(emptyCoinData.coinTypes.isEmpty)
//        
//        // Test case 2: Single coin type with a single coin
//        let quarter = CoinData.Coin(value: 0.25, count: 0)
//        let quarterType = CoinData.CoinType(icon: Image("quarter_icon"), currencies: [quarter], title: "Quarter", color: .green)
//        let singleCoinTypeData = CoinData(coinTypes: [quarterType])
//        XCTAssertEqual(singleCoinTypeData.coinTypes.count, 1)
//        XCTAssertEqual(singleCoinTypeData.coinTypes.first?.title, "Quarter")
//        XCTAssertEqual(singleCoinTypeData.coinTypes.first?.currencies.count, 1)
//        XCTAssertEqual((singleCoinTypeData.coinTypes.first?.currencies.first as? CoinData.Coin)?.value, 0.25)
//        
//        // Test case 3: Multiple coin types with multiple coins
//        let nickel = CoinData.Coin(value: 0.05, count: 0)
//        let dime = CoinData.Coin(value: 0.10, count: 0)
//        
//        let nickelType = CoinData.CoinType(icon: Image("nickel_icon"), currencies: [nickel], title: "Nickel", color: .orange)
//        let dimeType = CoinData.CoinType(icon: Image("dime_icon"), currencies: [dime], title: "Dime", color: .purple)
//        
//        let multipleCoinTypeData = CoinData(coinTypes: [quarterType, nickelType, dimeType])
//        XCTAssertEqual(multipleCoinTypeData.coinTypes.count, 3)
//        XCTAssertEqual(multipleCoinTypeData.coinTypes[0].title, "Quarter")
//        XCTAssertEqual(multipleCoinTypeData.coinTypes[1].title, "Nickel")
//        XCTAssertEqual(multipleCoinTypeData.coinTypes[2].title, "Dime")
//        XCTAssertEqual(multipleCoinTypeData.coinTypes[0].currencies.count, 1)
//        XCTAssertEqual(multipleCoinTypeData.coinTypes[1].currencies.count, 1)
//        XCTAssertEqual(multipleCoinTypeData.coinTypes[2].currencies.count, 1)
//        XCTAssertEqual((multipleCoinTypeData.coinTypes[0].currencies.first as? CoinData.Coin)?.value, 0.25)
//        XCTAssertEqual((multipleCoinTypeData.coinTypes[1].currencies.first as? CoinData.Coin)?.value, 0.05)
//        XCTAssertEqual((multipleCoinTypeData.coinTypes[2].currencies.first as? CoinData.Coin)?.value, 0.10)
//    }
//    
//    func testReset() {
//        // Set some values to the coins and other
//        let coin1 = fullCoinDataCHF.coinTypes[0].currencies[0] as! CoinData.Coin
//        coin1.count = 5
//        
//        let coin2 = fullCoinDataCHF.coinTypes[1].currencies[2] as! CoinData.Coin
//        coin2.count = 10
//        
//        let other1 = fullCoinDataCHF.coinTypes[3].currencies[0] as! CoinData.Other
//        other1.total = 50.0
//        
//        // Reset the coin types
//        fullCoinDataCHF.reset()
//        
//        // Check if the values are reset to 0
//        XCTAssertEqual(coin1.count, 0)
//        XCTAssertEqual(coin2.count, 0)
//        XCTAssertEqual(other1.getTotal(), 0.0)
//    }
//    
//    func testGetTotal() {
//        // Set some values to the coins and other
//        (fullCoinDataCHF.coinTypes[0].currencies[0] as! CoinData.Coin).count = 5
//        (fullCoinDataCHF.coinTypes[0].currencies[2] as! CoinData.Coin).count = 12
//        
//        (fullCoinDataCHF.coinTypes[1].currencies[0] as! CoinData.Coin).count = 2
//        (fullCoinDataCHF.coinTypes[1].currencies[1] as! CoinData.Coin).count = 3
//        (fullCoinDataCHF.coinTypes[1].currencies[2] as! CoinData.Coin).count = 10
//        
//        (fullCoinDataCHF.coinTypes[2].currencies[0] as! CoinData.Coin).count = 1
//        (fullCoinDataCHF.coinTypes[2].currencies[2] as! CoinData.Coin).count = 3
//        (fullCoinDataCHF.coinTypes[2].currencies[3] as! CoinData.Coin).count = 4
//        
//        (fullCoinDataCHF.coinTypes[3].currencies[0] as! CoinData.Other).total = 152.67
//        
//        
//        let totalCoinType1 = fullCoinDataCHF.coinTypes[0].getTotal()
//        let totalCoinType2 = fullCoinDataCHF.coinTypes[1].getTotal()
//        let totalCoinType3 = fullCoinDataCHF.coinTypes[2].getTotal()
//        let totalCoinType4 = fullCoinDataCHF.coinTypes[3].getTotal()
//        
//        let grandTotal = fullCoinDataCHF.getTotal()
//        
//        // Expected totals
//        let expectedTotalCoinType1:Double = 5.0 * 5.0 + 1.0 * 12
//        let expectedTotalCoinType2:Double = 500.0 * 2.0 + 200.0 * 3.0 + 100.0 * 10.0
//        let expectedTotalCoinType3:Double = 125.0 * 1.0 + 50.0 * 3.0 + 25.0 * 4.0
//        let expectedTotalCoinType4:Double = 152.67
//        
//        let expectedGrandTotal:Double = expectedTotalCoinType1 + expectedTotalCoinType2 + expectedTotalCoinType3 + expectedTotalCoinType4
//        
//        
//        // Check if the calculated totals match the expected values
//        XCTAssertEqual(totalCoinType1, expectedTotalCoinType1)
//        XCTAssertEqual(totalCoinType2, expectedTotalCoinType2)
//        XCTAssertEqual(totalCoinType3, expectedTotalCoinType3)
//        XCTAssertEqual(totalCoinType4, expectedTotalCoinType4)
//        
//        XCTAssertEqual(grandTotal, expectedGrandTotal)
//    }
//    
}
