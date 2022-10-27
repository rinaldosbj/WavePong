//
//  OnboardingCinco.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct DoisDedos: View {
    var body: some View {
        VStack(alignment: .center, spacing: 60){
            Text("Toque duas vezes para selecionar o que deseja ")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding()
                    .onTapGesture(count: 1) {
                        print("toquei")
                    }
            Image("dois dedos")
        }
    }
}

struct DoisDedos_Previews: PreviewProvider {
    static var previews: some View {
        DoisDedos()
    }
}
