//
//  PausarView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct PausarView: View {
    @State var scale: CGFloat = 1.0
    @State var animation = false
    @State var didColide = false
    
    let stringsConstants = StringsConstantsModel()
    
    var body: some View {
        ZStack{
            
            OnboardingSceneView(demoCase: .game, didColide: $didColide, isPause: true).ignoresSafeArea()
                
            VStack{
                Spacer()
                    .frame(height: 64)
                
                Text(stringsConstants.dois_toques)
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

struct PausarView_Previews: PreviewProvider {
    static var previews: some View {
        PausarView()
    }
}
