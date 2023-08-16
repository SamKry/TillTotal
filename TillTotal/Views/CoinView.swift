//
//  CoinViewWithSwype.swift
//  CalcBlue
//
//  Created by Samuel Kreyenbühl on 10.02.23.
//

import SwiftUI

struct CoinView: View {

    @State var currentDragOffsetX: CGFloat = 0  // must stay 0

    let h:CGFloat = 70
    let dragThreashold:CGFloat = 70
    
    
    fileprivate func TextFieldAmount() -> some View {
        return TextField("Amount", value: $number, formatter: CustomNumberFormatter.getIntFormatter())
            .padding(5)
            .frame(width: 100, height: 35)
            .background(Color("Background"))
            .cornerRadius(5)
            .keyboardType(.numberPad)
    }
    
    fileprivate func TextFieldTotal() -> some View {
        return TextField("Total", value: $total, formatter: CustomNumberFormatter.getDecimalFormatter())
            .padding(5)
            .frame(width: 100, height: 35)
            .background(Color("Background"))
            .cornerRadius(5)
            .keyboardType(.decimalPad)
    }
    
    @State var value:Double
    @State var number:Int64
    @State var total:Double
    let icon:Image

    var body: some View {
        ZStack {
            Color("Neutral-Ultra")
            HStack(spacing: 0) {
                icon
                    .padding(.trailing, 5)
                
                if Double(Int(value)) == value{
                    
                    Text(String(Int(value)))
                }
                else{
                    Text(String(value))
                }
                
                Spacer()
                
                Text("x")
                
                TextFieldAmount()
                    .onChange(of: number, perform:{ [self] i in
                        // TODO: update total
                    })
                    .padding(.leading, 5)
                
                Text("=")
                    .padding(.horizontal, 5)
                TextFieldTotal()
                    .foregroundColor(Color("Idle"))
                    .onChange(of: number, perform:{ i in
                        if (self.value == 0) {
                            self.number = 0
                        }
                        else{
                            //                        TODO: Update number
                        }
                    })
                
            }
            .foregroundColor(Color("Main"))
            .font(.system(size: 20, weight: .light))
            .padding(.horizontal, 10)
        }
            .modifier(DragGestureViewModifier(
                    onUpdate: { value in
                        withAnimation(.easeInOut(duration: 0.4)){
                            currentDragOffsetX = value.translation.width
                        }
                    },
                    onEnd: {
                        withAnimation(.easeInOut(duration: 0.2)){
                            if currentDragOffsetX < -dragThreashold{
                                number+=1
                                hapticFeedabck()
                            }else if currentDragOffsetX > dragThreashold{
                                if number > 0{
                                    number-=1
                                    hapticFeedabck()
                                }
                            }
                            currentDragOffsetX = 0
                        }
                    },
                    onCancel: {
                        withAnimation(.easeInOut(duration: 0.2)){
                            if currentDragOffsetX < -dragThreashold{
                                number+=1
                            }else if currentDragOffsetX > dragThreashold{
                                if number > 0{
                                    number-=1
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
                        .foregroundColor((number != 0) ? .red : .secondary)
                    Spacer()
                    Image(systemName: "plus.circle")
                        .foregroundColor(.green)
                }
                    .font(.system(size: 25, weight: .heavy))
                    .padding(.horizontal)
                    .shadow(color: .black, radius: 7, x: -5, y: 5)
            )
    }
    func hapticFeedabck(){
        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
        impactHeavy.impactOccurred()
    }
}


struct CoinViewSimple_Previews: PreviewProvider {
    static var previews: some View {
        CoinView(value: 2.3, number: 32, total: 303.32, icon: Image(systemName: "folder"))
            .frame(height: 70)
            .cornerRadius(70/4)
            .padding(.horizontal, 20)
    }
}
