//
//  CoinDataHelperTests.swift
//  TillTotalTests
//
//  Created by Samuel Kreyenbühl on 19.07.23.
//

import XCTest
import SwiftUI

final class CoinDataHelperTests: XCTestCase {

//    func testInitFullCoinDataCHF() {
//        let emptyCoinData = CoinDataHelper.initEmptyCoinData()
//
//        // Test if fullCoinDataCHF is not nil after initialization
//        XCTAssertNotNil(emptyCoinData)
//
//        // Test if the number of coin types matches the expected value (3 in this case)
//        XCTAssertEqual(emptyCoinData.coinTypes.count, 4)
//
//        // Test the properties of each coin type
//        let coinType1 = emptyCoinData.coinTypes[0]
//        XCTAssertEqual(coinType1.title, "Münzen")
//        XCTAssertEqual(coinType1.color, .green)
//        XCTAssertEqual(coinType1.currencies.count, 7)
//        for currency in coinType1.currencies {
//            XCTAssertTrue(currency is CoinData.Coin)
//        }
//
//        let coinType2 = emptyCoinData.coinTypes[1]
//        XCTAssertEqual(coinType2.title, "Noten")
//        XCTAssertEqual(coinType2.color, .blue)
//        XCTAssertEqual(coinType2.currencies.count, 6)
//        for currency in coinType2.currencies {
//            XCTAssertTrue(currency is CoinData.Coin)
//        }
//
//        let coinType3 = emptyCoinData.coinTypes[2]
//        XCTAssertEqual(coinType3.title, "Münzrollen")
//        XCTAssertEqual(coinType3.color, .orange)
//        XCTAssertEqual(coinType3.currencies.count, 7)
//        for currency in coinType3.currencies {
//            XCTAssertTrue(currency is CoinData.Coin)
//        }
//
//        let coinType4 = emptyCoinData.coinTypes[3]
//        XCTAssertEqual(coinType4.title, "Andere")
//        XCTAssertEqual(coinType4.color, .red)
//        XCTAssertEqual(coinType4.currencies.count, 2)
//        for currency in coinType4.currencies {
//            XCTAssertTrue(currency is CoinData.Other)
//        }
//
//        // Test the properties of coins within each coin type
//        XCTAssertEqual((coinType1.currencies[0] as! CoinData.Coin).value, 5)
//        XCTAssertEqual((coinType1.currencies[1] as! CoinData.Coin).value, 2)
//        XCTAssertEqual((coinType1.currencies.last as! CoinData.Coin).value, 0.05)
//
//        XCTAssertEqual((coinType2.currencies[0] as! CoinData.Coin).value, 500)
//        XCTAssertEqual((coinType2.currencies[2] as! CoinData.Coin).value, 100)
//        XCTAssertEqual((coinType2.currencies.last as! CoinData.Coin).value, 10)
//
//        XCTAssertEqual((coinType3.currencies[0] as! CoinData.Coin).value, 125)
//        XCTAssertEqual((coinType3.currencies[4] as! CoinData.Coin).value, 10)
//        XCTAssertEqual((coinType3.currencies.last as! CoinData.Coin).value, 2.5)
//
//        // Loop over all currencies in coinTypes and check if count is 0
//        for coinType in emptyCoinData.coinTypes {
//            for currency in coinType.currencies {
//                if(currency is CoinData.Coin){
//                    XCTAssertEqual((currency as! CoinData.Coin).count, 0)
//                }
//                else if (currency is CoinData.Other){
//                    XCTAssertEqual((currency as! CoinData.Other).total, 0)
//                }
//                else{
//                    XCTFail("Currency is not of type CoinData.Coin or CoinData.Other")
//                }
//            }
//        }
//
//        // Loop over all currencies in coinTypes and check if getTotal() returns 0.0
//        for coinType in emptyCoinData.coinTypes {
//            for currency in coinType.currencies {
//                XCTAssertEqual(currency.getTotal(), 0.0)
//            }
//        }
//    }
}
