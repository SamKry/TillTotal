//
//  CoinTypeView.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 12.08.23.
//

import SwiftUI

struct CoinTypeView: View {
    let vm:CoinTypeViewModel
    
    
    
    @State var totalNeedsUpdate:Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{                
                Text(vm.name)
                
                    .font(.largeTitle)
                    .foregroundColor(Color("Main"))
                Spacer()
                
                Text("Subtotal: \(vm.total, specifier: "%.2f")")
            }
            .padding(.horizontal)
            .onChange(of: vm.total) { newValue in
                print(newValue)
            }
            
            ScrollView(showsIndicators: false){
                Spacer(minLength: 20)
                ForEach(vm.coins) { coin in
                    let cVM = CoinViewModel(coinEntity: coin, superVM: vm)
                    CoinView(viewModel: cVM)
                        .onChange(of: cVM.number) { neNumber in
                            print(neNumber)
                        }
                }
                Spacer()
            }
            .onChange(of: totalNeedsUpdate) { newValue in
                vm.updateTotal()
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .background(
            Color("Neutral-Ultra")
        )
        .cornerRadius(30)
//        .shadow(color: Color("Neutral-Ultra.reversed"), radius: 10, x: -5, y: 5)
        
    }
}
