//
//  CoinTypeView.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 12.08.23.
//

import SwiftUI

struct CoinTypeView: View {
    @ObservedObject var vm:CoinTypeViewModel
    
    init(vm: CoinTypeViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                HStack{
                    Text(vm.name)
                    Spacer()
                }
                .font(.largeTitle)
                .foregroundColor(Color("Main"))
                .padding(.horizontal)
                
                ScrollView(showsIndicators: false){
                    Spacer(minLength: 20)
                    ForEach(vm.coinVMs) { coinvm in
                        CoinView(viewModel: coinvm)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
            }
            VStack{
                Spacer()
                if (vm.isOther) {
                    Button {
                        withAnimation {
                            vm.addOther()
                        }
                    } label: {
                        ZStack{
                            Circle()
                                .fill(Color(.neutralMedium))
                                .frame(width: 60, height: 60)
                                .shadow(color: Color(.neutral).opacity(0.25), radius: 3, x: 5, y: 5)
                            
                            Image(systemName: "plus.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color(.main))
                                .frame(width: 40, height: 40)
                        }
                    }
                    .offset(x: ((UIScreen.main.bounds.width - 60) / 2)-15)
                    .padding(.bottom, 15)
                }
            }
        }
        .onAppear{
            vm.reloadModel()
        }
        .padding(.top)
        .background(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 30)
            .fill(Color("Neutral-Ultra"))
        )
    }
}

struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
