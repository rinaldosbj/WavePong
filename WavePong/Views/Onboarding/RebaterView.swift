//
//  RebaterView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct RebaterView: View {
    
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
                
                Text(stringsConstants.raquete_bola)
                    .font(Font.wavePongPrimary(.headline))
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.1)
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .multilineTextAlignment(.center)
                    .frame(width: 310, height: 270, alignment: .center)
                    .accessibilityHint(stringsConstants.onboading_hint)
                Spacer()
                
                VStack {
                    
                    Image("Ball")
                        .rotationEffect(Angle(degrees: 250))
                        .foregroundColor(Color(ColorConstants.shared.YELLOW_600))
                        .offset(x: bola ? 100: 40, y: bola ? 0 : 100)
                        .animation(.easeOut(duration: 2).repeatForever(autoreverses: false),value: bola)
                        .accessibilityHidden(true)
                    Image("raquete")
                        .frame(width: 145, height: 33, alignment: .center)
                        .padding(20)
                        .accessibilityHidden(true)
                        .onAppear{
                            bola = true
                        }
                }
                Spacer()
            }
        }
    }
}

struct RebaterView_Previews: PreviewProvider {
    static var previews: some View {
        RebaterView()
    }
}
