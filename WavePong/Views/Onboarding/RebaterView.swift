//
//  RebaterView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct RebaterView: View {
    
    @Binding var didColide: Bool
    
    let stringsConstants = StringsConstantsModel()
    
    var body: some View {
        ZStack{
            
            OnboardingSceneView(demoCase: .game, didColide: $didColide, isPause: false).ignoresSafeArea()
                
            VStack{
                Spacer()
                    .frame(height: 64)
                
                Text(stringsConstants.raquete_bola)
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

