//
//  VolumeView.swift
//  WavePong
//
//  Created by rsbj on 03/10/23.
//

import SwiftUI

struct VolumeView: View {
    
    let stringsConstants = StringsConstantsModel()
    @State var didColide = false
    
    var body: some View {
        ZStack{
            
            OnboardingSceneView(demoCase: .volume, didColide: $didColide).ignoresSafeArea()
            
            VStack{
                Spacer()
                    .frame(height: 64)
                
                Text(stringsConstants.volume_onboarding)
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

#Preview {
    VolumeView()
}
