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
    
    @State var total:Double = 0.0
    
    init(viewModel:CoinViewModel) {
        self.viewModel = viewModel
    }
    
    func calcTotal(_ newNumber:Int64){
        viewModel.number = Int64(Double(newNumber)+0.5)
        self.total = viewModel.value*Double(viewModel.number)
    }
    
    func calcNumber(_ newTotal:Double){
        viewModel.number = Int64((newTotal/viewModel.value)+0.5)
        calcTotal(viewModel.number)
    }
    
    var other: some View {
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
    
    var notOther: some View {
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
                TextFieldDecimal(value: $total, text: "Total")
                    .frame(width: 100)
                    .foregroundColor(Color("Idle"))
            }
            .foregroundColor(Color("Main"))
            .font(.system(size: 20, weight: .light))
            .padding(.horizontal, 12)
        }
        
        .frame(height: 70)
        .cornerRadius(70/4)
        
        .modifier(DragGestureViewModifier(
            onUpdate: { value in
                KeyboardHandler.hideKeyboard()
                withAnimation(.easeInOut(duration: 0.4)){
                    currentDragOffsetX = value.translation.width
                }
            },
            onEnd: {
                withAnimation(.easeInOut(duration: 0.2)){
                    if currentDragOffsetX < -dragThreashold{
                        viewModel.number+=1
                        HapticFeedback.ok()
                    }else if currentDragOffsetX > dragThreashold{
                        if viewModel.number > 0{
                            viewModel.number-=1
                            HapticFeedback.ok()
                        }
                    }
                    currentDragOffsetX = 0
                }
            },
            onCancel: {
                withAnimation(.easeInOut(duration: 0.2)){
                    if currentDragOffsetX < -dragThreashold{
                        viewModel.number+=1
                    }else if currentDragOffsetX > dragThreashold{
                        if viewModel.number > 0{
                            viewModel.number-=1
                        }
                    }
                    currentDragOffsetX = 0
                }
            }
        ))
        .offset(x: currentDragOffsetX)
        .background(
            HStack{
                Image(systemName: "minus.circle")
                    .foregroundColor((viewModel.number != 0) ? Color("Error") : Color("Neutral-Medium"))
                Spacer()
                Image(systemName: "plus.circle")
                    .foregroundColor(Color("Idle"))
            }
                .font(.system(size: 25, weight: .heavy))
                .padding(.horizontal)
        )
    }
    
    var body: some View {
        var view: AnyView
        
        if viewModel.isOther {
            view = AnyView(other)
        }
        else {
            view = AnyView(notOther)
        }
        
        return view
            .onAppear{
                calcTotal(viewModel.number)
            }
            .onChange(of: viewModel.number) { newNumber in
                calcTotal(newNumber)
            }
            .onChange(of: total) { newTotal in
                calcNumber(newTotal)
            }
    }
}

