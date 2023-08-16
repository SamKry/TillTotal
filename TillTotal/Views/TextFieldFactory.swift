//
//  TextFieldFactory.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 11.08.23.
//

import SwiftUI

func TextFieldInt(value: Binding<Int64>, text:String) -> some View {
    return TextField(text, value: value, formatter: CustomNumberFormatter.getIntFormatter())
        .padding(7)
        .frame(height: 35)
        .background(Color("Neutral-Ultra"))
        .cornerRadius(7)
        .keyboardType(.numberPad)
}

func TextFieldDecimal(value: Binding<Double>, text:String) -> some View {
    return TextField(text, value: value, formatter: CustomNumberFormatter.getDecimalFormatter())
        .padding(7)
        .frame(height: 35)
        .background(Color("Neutral-Ultra"))
        .cornerRadius(7)
        .keyboardType(.decimalPad)
}
