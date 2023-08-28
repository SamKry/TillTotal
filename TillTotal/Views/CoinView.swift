//
//  CoinViewWithSwype.swift
//  CalcBlue
//
//  Created by Samuel Kreyenbühl on 10.02.23.
//

import SwiftUI

struct CoinView: View {
    @State var currentDragOffsetX: CGFloat = 0  // must stay 0!
    private let dragThreashold:CGFloat = 70
    
    @ObservedObject var viewModel:CoinViewModel
    
    init(viewModel:CoinViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        var view: AnyView
        
        if viewModel.isOther {
            view = AnyView(getOther())
        }
        else {
            view = AnyView(getNotOther())
        }
        
        return view
            .onAppear{
                viewModel.reloadModel()
                viewModel.calcTotal()
            }
            .onChange(of: viewModel.number) { _ in
                viewModel.calcTotal()
            }
            .onChange(of: viewModel.total) { _ in
                viewModel.calcNumber()
            }
            .modifier(DragGestureViewModifier(
                onUpdate: { value in
                    KeyboardHandler.hideKeyboard()
                    withAnimation(.easeInOut(duration: 0.4)){
                        currentDragOffsetX = value.translation.width
                    }
                },
                onEnd: {
                    dragged()
                },
                onCancel: {
                    dragged()
                }
            ))
            .offset(x: currentDragOffsetX)
            .background(
                HStack{
                    if(viewModel.didSubstract != nil){
                        Image(systemName: "minus.circle")
                            .foregroundColor((viewModel.number != 0) ? Color("Error") : Color("Neutral-Medium"))
                    }
                    Spacer()
                    if(viewModel.didAdd != nil){
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color("Idle"))
                    }
                }
                    .font(.system(size: 25, weight: .heavy))
                    .padding(.horizontal)
            )
    }
    
    private func getOther() -> some View {
        ZStack {
            Color("Neutral-Medium")
            HStack(spacing: 0) {
                viewModel.icon
                Spacer()
                TextFieldDecimal(value: $viewModel.value, text: "Betrag")
                    .padding(.leading, 7)
            }
            .foregroundColor(Color("Main"))
            .font(.system(size: 20, weight: .light))
            .padding(.horizontal, 12)
        }
        .frame(height: 70)
        .cornerRadius(70/4)
    }
    
    private func getNotOther() -> some View {
        ZStack {
            Color("Neutral-Medium")
            HStack(spacing: 0) {
                viewModel.icon
                    .padding(.trailing, 5)
                
                if (viewModel.value.truncatingRemainder(dividingBy: 1) == 0) {
                    Text(String(Int(viewModel.value)))
                } else {
                    Text(String(viewModel.value))
                }
                
                Spacer()
                
                Text("x")
                
                TextFieldInt(value: $viewModel.number, text: "Anzahl")
                    .frame(width: 100)
                    .padding(.leading, 7)
                
                Text("=")
                    .padding(.horizontal, 7)
                TextFieldDecimal(value: $viewModel.total, text: "Total")
                    .frame(width: 100)
                    .foregroundColor(Color("Idle"))
            }
            .foregroundColor(Color("Main"))
            .font(.system(size: 20, weight: .light))
            .padding(.horizontal, 12)
        }
        
        .frame(height: 70)
        .cornerRadius(70/4)
        
       
    }
    
    fileprivate func dragged() {
        withAnimation(.easeInOut(duration: 0.2)){
            if (currentDragOffsetX < -dragThreashold) {
                if(viewModel.didAdd != nil) {
                    viewModel.didAdd!()
                }
            } else if (currentDragOffsetX > dragThreashold) {
                if(viewModel.didSubstract != nil){
                    viewModel.didSubstract!()
                }
            }
            currentDragOffsetX = 0
        }
    }
    
}

