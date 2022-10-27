//
//  OnboardingDois.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 26/10/22.
//

import SwiftUI

struct OnboardingDois: View {
    var body: some View {
        VStack{
            Text("Toque uma vez para ouvir o que está na tela")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding()
                    .onTapGesture(count: 1) {
                        print("toquei")
                    }
            Image("dois toques")
    }

}

struct OnboardingDois_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDois()
    }
}
}
