//
//  Onboarding.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 25/10/22.
//

import SwiftUI

struct OnboardingUm: View {
    var body: some View {
        
        VStack{
            Text("Coloque o fone de ouvido, depois toque na tela para continuar").font(.custom("DaysOne-Regular", size: 35))
                .bold()
                .padding()
                .onTapGesture(count: 1) {
                    print("toquei")
                }
                
            Image("fone")
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingUm()
    }
}
