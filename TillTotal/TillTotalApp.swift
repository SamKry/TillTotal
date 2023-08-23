//
//  TillTotalApp.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 15.07.23.
//

import SwiftUI

@main
struct TillTotalApp: App {
    
    var body: some Scene {
        WindowGroup {
            let till = CoinDataLoader.loadTillOrCreate()
            ContentView(vm: ContentViewModel(till: till, currency: till.currency!))
        }
    }
}
