//
//  RaqueteView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct RaqueteView: View {
    
    @State var deslize = 100
    @State var animation = false
    
    var body: some View {
        ZStack{
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            VStack {
                Spacer()
                    .frame(height: 64)
                
                Spacer()
                
                Text("\(Text("Deslize").foregroundColor(.yellow)) os dedos para os lados para \(Text("mover").foregroundColor(.yellow)) a raquete e rebater a bola")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 310, height: 270, alignment: .center)
                    .accessibilityHint("Toque duas vezes na tela para continuar")
                
                Spacer()
                
                VStack{
                    
                    Image("raquete")
                        .frame(width: 145, height: 33)
                        .offset(x: CGFloat(deslize))
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true),value: animation)
                        .onAppear{
                            deslize = -100
                            animation.toggle()
                        }
                        .accessibilityHidden(true)

                }
                Spacer()
            }
        }
    }
}

struct RaqueteView_Previews: PreviewProvider {
    static var previews: some View {
        RaqueteView()
    }
}
