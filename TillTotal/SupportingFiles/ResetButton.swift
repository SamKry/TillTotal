//
//  ResetButton.swift
//  CalcBlue
//
//  Created by Samuel Kreyenbühl on 08.04.23.
//

import SwiftUI

struct ResetButton: View {
    let buttonWidth:CGFloat
    let buttonHeigth:CGFloat
    let restOffset:CGFloat
    @State var currentDragOffsetX: CGFloat
    @State var buttonColor:Color
    var onEnd: Callback
    
    init(onEnd:@escaping Callback){
        buttonWidth = UIScreen.main.bounds.size.width*0.85
        buttonHeigth = 70
        restOffset = -buttonWidth/2+buttonHeigth/2
        currentDragOffsetX = restOffset
        buttonColor = Color("Neutral-Ultra")
        self.onEnd = onEnd
    }
    
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 20)
                .fill(buttonColor)
            Text("Swipe to reset")
                .font(.system(size: 25, weight: .light))
            
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("Main"))
                    .frame(width: buttonHeigth-5, height: buttonHeigth-5)
                    .shadow(color: Color("Neutral").opacity(0.5), radius: 3, x: -5, y: 5)
                Image(systemName: "chevron.right")
            }
            .offset(x:currentDragOffsetX)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let value_ = value.translation.width+restOffset
                        withAnimation {
                            if(value_ < restOffset)
                            {
                                currentDragOffsetX = restOffset
                            }
                            else if(value_ > restOffset+buttonWidth-buttonHeigth){
                                currentDragOffsetX = restOffset+buttonWidth-buttonHeigth
                            }
                            else{
                                currentDragOffsetX = value_
                            }
                        }
                        if(value.translation.width > buttonWidth*0.75){
                            withAnimation {
                                buttonColor = Color("Error")
                            }
                        }
                        else{
                            buttonColor = Color("Neutral-Ultra")
                        }
                    })
                    .onEnded({ value in
                        withAnimation {
                            currentDragOffsetX = restOffset
                            if(value.translation.width > buttonWidth*0.75){
                                onEnd()
                                HapticFeedback.ok()
                            }
                        }
                        buttonColor = Color("Neutral-Ultra")
                    })
            )
            
//            .modifier(DragGestureViewModifier(
//                onUpdate: { value in
//                    KeyboardHandler.hideKeyboard()
//                    withAnimation(.easeInOut(duration: 0.4)){
//                        currentDragOffsetX = value.translation.width
//                    }
//                },
//                onEnd: {
//                    withAnimation(.easeInOut(duration: 0.2)){
//                        if currentDragOffsetX < -dragThreashold{
//                            viewModel.number+=1
//                            HapticFeedback.ok()
//                        }else if currentDragOffsetX > dragThreashold{
//                            if viewModel.number > 0{
//                                viewModel.number-=1
//                                HapticFeedback.ok()
//                            }
//                        }
//                        currentDragOffsetX = 0
//                    }
//                },
//                onCancel: {
//                    withAnimation(.easeInOut(duration: 0.2)){
//                        if currentDragOffsetX < -dragThreashold{
//                            viewModel.number+=1
//                        }else if currentDragOffsetX > dragThreashold{
//                            if viewModel.number > 0{
//                                viewModel.number-=1
//                            }
//                        }
//                        currentDragOffsetX = 0
//                    }
//                }
//            ))
//            .offset(x: currentDragOffsetX)
            
        }
        .frame(width: buttonWidth, height: buttonHeigth)
    }
}

struct ResetButton_Previews: PreviewProvider {
    static var previews: some View {
        ResetButton{
            print("reset")
        }
    }
}
