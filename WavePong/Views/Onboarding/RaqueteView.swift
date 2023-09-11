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
    
    let stringsConstants = StringsConstantsModel()
    
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
                
                Text(stringsConstants.mover_raquete)
                    .font(.custom("DaysOne-Regular", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .multilineTextAlignment(.center)
                    .frame(width: 310, height: 270, alignment: .center)
                    .accessibilityHint(stringsConstants.onboading_hint)
                
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
