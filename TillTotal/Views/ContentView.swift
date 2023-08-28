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
    
    @State var coinTypeVMs:[CoinTypeViewModel]
    
    
    init(vm:ContentViewModel) {
        self.vm = vm
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("Neutral-Medium"))
        self.coinTypeVMs = vm.coinTypeVMs
    }
    
    var body: some View {
        TabView {
            ForEach(coinTypeVMs) { coinTypeVM in 
                CoinTypeView(vm: coinTypeVM)
                    .onTapGesture {
                        KeyboardHandler.hideKeyboard()
                    }.tabItem {
                        coinTypeVM.icon
                        Text(coinTypeVM.name)
                    }
            }
            
            TillView(vm: TillViewModel(tillEntity: vm.till), contentVM: vm)
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Abrechnung")
                }
        }
        .accentColor(Color("Main"))
    }
}
