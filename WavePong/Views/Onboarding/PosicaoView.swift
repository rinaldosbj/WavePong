//
//  PosicaoView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct PosicaoView: View {
    
    let stringsConstants = StringsConstantsModel()
    @State var didColide = false
    
    var body: some View {
        ZStack{
            
            OnboardingSceneView(demoCase: .pan, didColide: $didColide, isPause: false).ignoresSafeArea()
            
            VStack{
                Spacer()
                    .frame(height: 64)
                
                Text(stringsConstants.bola_guiada)
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

struct PosicaoView_Previews: PreviewProvider {
    static var previews: some View {
        PosicaoView()
    }
}
