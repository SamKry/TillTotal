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
    @State private var selection = "Münzen" // change for testing
    
    
    init(vm:ContentViewModel) {
        self.vm = vm
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("Neutral-Medium"))
        self.coinTypeVMs = vm.coinTypeVMs
        ScreenSaver.disableAutoLock()
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(coinTypeVMs) { coinTypeVM in
                CoinTypeView(vm: coinTypeVM)
                    .onTapGesture {
                        KeyboardHandler.hideKeyboard()
                        coinTypeVM.revalidateAll()
                    }.tabItem {
                        coinTypeVM.icon
                        Text(coinTypeVM.name)
                    }
                    .tag(coinTypeVM.name)
            }
            
            TillView(vm: TillViewModel(tillEntity: vm.till), contentVM: vm)
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Abrechnung")
                }
                .tag("Abrechnung")
        }
        .scrollDismissesKeyboard(ScrollDismissesKeyboardMode.interactively)
        .accentColor(Color("Main"))
    }
}
