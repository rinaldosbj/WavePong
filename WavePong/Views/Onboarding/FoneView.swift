//
//  FoneView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct FoneView: View {
    
    let stringsConstants = StringsConstantsModel()
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            VStack{
                Text(stringsConstants.coloque_fone)
                    .font(.custom("DaysOne-Regular", size: 35))
                    .foregroundColor(.white)
                    .bold()
                    .minimumScaleFactor(0.1)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    .padding()
                    .accessibilityHint(stringsConstants.onboading_hint)
                
                Image("fone")
                    .accessibilityHidden(true)
            }
        }
    }
}

struct FoneView_Previews: PreviewProvider {
    static var previews: some View {
        FoneView()
    }
}
