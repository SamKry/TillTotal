//
//  ContentView.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var vm:ContentViewModel
    
    init(vm:ContentViewModel) {
        self.vm = vm
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("Neutral-Medium"))
    }
    
    var body: some View {
        
        // Loop over coinTypes
        TabView {
            ForEach(vm.coinTypes) { coinType in
                CoinTypeView(vm: CoinTypeViewModel(coinTypeEntity: coinType))
                    .onTapGesture {
                        KeyboardHandler.hideKeyboard()
                    }.tabItem {
                        Image(systemName: coinType.icon ?? "exclamationmark.questionmark")
                        Text(coinType.name ?? "noName")
                    }
            }
            
            TillView(vm: TillViewModel(tillEntity: vm.till))
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Abrechnung")
                }
        }
        .accentColor(Color("Main"))
    }
}
