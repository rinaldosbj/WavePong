//
//  OnboardingQuatro.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct ArrasteEsquerda: View {
    var body: some View {
        VStack{
            Text("Arraste para os lados para navegar pelo menu")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding(40)
                    .onTapGesture(count: 1) {
                        print("toquei")
                    }
            Image("arraste esquerda")
        }
    }
}

struct ArrasteEsquerda_Previews: PreviewProvider {
    static var previews: some View {
        ArrasteEsquerda()
    }
}
