//
//  TextFieldFactory.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 11.08.23.
//

import SwiftUI

func TextFieldInt(value: Binding<Int64>, text:String, onSubmitAction:@escaping() -> Void) -> some View {
    return TextField(text, value: value, formatter: CustomNumberFormatter.getIntFormatter())
        .onSubmit {
            onSubmitAction()
        }
        .padding(7)
        .frame(height: 35)
        .background(Color("Neutral-Ultra"))
        .cornerRadius(7)
        .keyboardType(.numberPad)
}

func TextFieldDecimal(value: Binding<Double>, text:String, onSubmitAction:@escaping() -> Void) -> some View {
    return TextField(text, value: value, formatter: CustomNumberFormatter.getDecimalFormatter())
        .onSubmit {
            onSubmitAction()
        }
        .padding(7)
        .frame(height: 35)
        .background(Color("Neutral-Ultra"))
        .cornerRadius(7)
        .keyboardType(.decimalPad)
}
    
