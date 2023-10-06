//
//  RaqueteView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct RaqueteView: View {
    
    @State var didColide = false
    
    @State var deslize = 100
    @State var animation = false
    
    let stringsConstants = StringsConstantsModel()
    
    var body: some View {
        ZStack{
            
            OnboardingSceneView(demoCase: .game, didColide: $didColide, isPause: false).ignoresSafeArea()
                
            VStack{
                Spacer()
                    .frame(height: 64)
                
                Text(stringsConstants.mover_raquete)
                    .font(Font.wavePongPrimary(.headline))
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.1)
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .multilineTextAlignment(.center)
                    .frame(width: 310, height: 270, alignment: .center)
                    .padding(.bottom, -32)
                    .accessibilityHint(stringsConstants.onboading_hint)
                
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
