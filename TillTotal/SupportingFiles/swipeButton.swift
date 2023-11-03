//
//  swipeButton.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 31.10.23.
//

import SwiftUI

struct swipeButton: View {
    @State private var offset: CGFloat = 0.0
    
    var body: some View {
        Text("Reset")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.offset = value.translation.width
                    }
                    .onEnded { _ in
                        withAnimation {
                            self.offset = 0.0
                        }
                    }
            )
    }
}

struct swipeButton_Previews: PreviewProvider {
    static var previews: some View {
        swipeButton()
    }
}
