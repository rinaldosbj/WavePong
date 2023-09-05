//
//  PosicaoView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct PosicaoView: View {
    
    @State var bola = false
    
    let stringsConstants = StringsConstantsModel()
    
    var body: some View {
        ZStack{
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            VStack{
                Spacer()
                    .frame(height: 64)
                
                Spacer()
                
                Text(stringsConstants.bola_guiada)
                    .font(.custom("DaysOne-Regular", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 310, height: 270, alignment: .center)
                    .padding(.bottom, -32)
                    .accessibilityHint(stringsConstants.onboading_hint)
                
                ZStack {
                    VStack {
                        Image("Ball")
                            .offset(x: bola ? 40: -60, y: bola ? 100: 0)
                            .animation(.easeOut(duration: 1.5).repeatForever(autoreverses: false),value: bola)
                            .accessibilityHidden(true)
                        Image("raquete")
                            .scaledToFill()
                            .frame(width: 145, height: 33, alignment: .center)
                            .padding(.top, 100)
                            .accessibilityHidden(true)
                        
                    }
                }
                Spacer()
            }
        }
        .onAppear{
            bola = true
        }
    }
}

struct PosicaoView_Previews: PreviewProvider {
    static var previews: some View {
        PosicaoView()
    }
}
