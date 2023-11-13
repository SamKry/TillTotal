//
//  BillingView.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 17.08.23.
//

import SwiftUI

struct TillView: View {
    
    @ObservedObject var vm: TillViewModel
    @ObservedObject var contentVM: ContentViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                HStack{
                    Text("Abrechnung")
                    Spacer()
                }
                .font(.largeTitle)
                .foregroundColor(Color("Main"))
                
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
                            Text("Bar brutto")
                            Text("\(String(format: "%.2f", vm.cashBrutto))")
                                .textSelection(.enabled)
                            Color.clear
                                .gridCellUnsizedAxes([.horizontal, .vertical])
                        }
                        GridRow {
                            Text("Bar netto")
                            Text("\(String(format: "%.2f", vm.cashNetto))")
                                .textSelection(.enabled)
                            Color.clear
                                .gridCellUnsizedAxes([.horizontal, .vertical])
                        }
                        
                        Divider()
                            .overlay(Color("Neutral-Ultra.reversed"))
                        GridRow {
                            Text("Gesamt")
                            Text("\(String(format: "%.2f", vm.getTotal()))")
                            
                            TextFieldDecimal(value: $vm.refrenceTotal, text: "Total soll", onSubmitAction: {})
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
            
            VStack {
                VStack {
                    HStack {
                        Text("Einstellungen")
                            .font(.largeTitle)
                            .foregroundColor(Color("Main"))
                        Spacer()
                    }
                    
                    VStack {
                        HStack {
                            Text("Kassenstock:")
                                .padding(.vertical)
                            
                            Spacer()
                            
                            TextFieldDecimal(value: $vm.cashStock, text: "Kassenstock", onSubmitAction: {} )
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
            
            
            Spacer()
        }
        .onAppear{
            vm.refetchAndUpdateVariables()
        }
        .onTapGesture {
            KeyboardHandler.hideKeyboard()
        }
    }
}
