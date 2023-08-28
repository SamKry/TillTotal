//
//  CoinTypeView.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 12.08.23.
//

import SwiftUI

struct CoinTypeView: View {
    @ObservedObject var vm:CoinTypeViewModel
    
    init(vm: CoinTypeViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{
                Text(vm.name)
                
                    .font(.largeTitle)
                    .foregroundColor(Color("Main"))
                Spacer()
                
                Text("Zwischentotal: na")
            }
            .padding(.horizontal)
            
            ScrollView(showsIndicators: false){
                Spacer(minLength: 20)
                ForEach(vm.coins) { coin in
                    let cVM = CoinViewModel(coinEntity: coin, isOther: vm.isOther, didDelete: vm.reloadModel)
                    CoinView(viewModel: cVM)
                }
                Spacer()
            }
            
            if (vm.isOther) {
                Button {
                    withAnimation {
                        vm.addOther()
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.green)
                        .frame(width: 40, height: 40)
                        .padding(.bottom, 10)
                }
            }
        }
        .onAppear{
            vm.reloadModel()
        }
        .padding(.horizontal)
        .padding(.top)
        .background(
            Color("Neutral-Ultra")
        )
        .cornerRadius(30)
    }
}
