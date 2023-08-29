//
//  SettinsView.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 17.08.23.
//

import SwiftUI

struct SettinsView: View {
    
    @ObservedObject var vm: TillViewModel
    @ObservedObject var contentVM:ContentViewModel
    
    init(vm: TillViewModel, contentVM: ContentViewModel) {
        self.vm = vm
        self.contentVM = contentVM
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Einstellungen")
                        .font(.largeTitle)
                        .foregroundColor(Color("Main"))
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack {
                    
                    HStack {
                        Text("Kassenstock:")
                            .padding(.vertical)
                        
                        Spacer()
                        
                        TextFieldDecimal(value: $vm.cashStock, text: "Kassenstock")
                        
                    }
                    .foregroundColor(Color("Main"))
                    .font(.system(size: 20, weight: .light))
                    .padding(.horizontal, 10)
                    
                    ResetButton {
                        vm.reset()
                        contentVM.reset()
                    }
                    .padding(.bottom)
                }
                .background(Color("Neutral-Medium"))
                .cornerRadius(70/4)
            }
            .padding()
            .background(
                Color("Neutral-Ultra")
            )
            .cornerRadius(30)
        }
    }
}
