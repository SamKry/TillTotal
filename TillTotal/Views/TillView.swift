//
//  BillingView.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 17.08.23.
//

import SwiftUI

struct TillView: View {
    
    @ObservedObject var vm: TillViewModel
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("Abrechnung")
                        .font(.largeTitle)
                        .foregroundColor(Color("Main"))
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack {
                    
                    Grid(alignment: .leading, horizontalSpacing: 5, verticalSpacing: 10) {
                        GridRow {
                            Color.clear
                                .gridCellUnsizedAxes([.horizontal, .vertical])
                            Text("Ist")
                                .foregroundColor(Color("Neutral-Ultra.reversed"))
                            Text("Soll")
                                .foregroundColor(Color("Neutral-Ultra.reversed"))
                        }
                        .font(.system(size: 25, weight: .semibold))
                        
                        Divider()
                            .overlay(Color("Neutral-Ultra.reversed"))
                        GridRow {
                            Text("Andere")
                            Text("\(String(format: "%.2f", vm.othersIs))")
                                .textSelection(.enabled)
                            Color.clear
                                .gridCellUnsizedAxes([.horizontal, .vertical])
                        }
                        GridRow {
                            Text("Bar")
                            Text("\(String(format: "%.2f", vm.notOthersIs))")
                                .textSelection(.enabled)
                            Color.clear
                                .gridCellUnsizedAxes([.horizontal, .vertical])
                        }
                        
                        Divider()
                            .overlay(Color("Neutral-Ultra.reversed"))
                        GridRow {
                            Text("Gesammt")
                            Text("\(String(format: "%.2f", vm.getTotal()))")
                            TextFieldDecimal(value: $vm.refrenceTotal, text: "Total ist")
                                .keyboardType(.decimalPad)
                                .foregroundColor(Color("Main"))
                                .padding(5)
                                .frame(height: 35)
                                .cornerRadius(5)
                        }
                        Divider()
                            .overlay(Color("Neutral-Ultra.reversed"))
                        GridRow {
                            Text("Differenz = ")
                            Text("\(String(format: "%.2f", vm.diff))")
                                .textSelection(.enabled)
                            Color.clear
                                .gridCellUnsizedAxes([.horizontal, .vertical])
                        }
                        
                    }
                    .foregroundColor(Color("Main"))
                    .font(.system(size: 20, weight: .light))
                    .padding()
                }
                .background(Color("Neutral-Medium"))
                .cornerRadius(70/4)
            }
            
            .padding()
            .background(
                Color("Neutral-Ultra")
            )
            .cornerRadius(30)
            
            SettinsView(vm: vm)
            
            Spacer()
        }
        .onAppear{
            vm.updateVariables()
        }
        .onTapGesture {
            KeyboardHandler.hideKeyboard()
        }
    }
}
