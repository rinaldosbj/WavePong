//
//  OnboardingCinco.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct DoisDedos: View {
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 60){
                Text("\(Text("Clique").foregroundColor(.yellow)) com os \(Text("dois dedos").foregroundColor(.yellow)) para ouvir as \(Text("instruções").foregroundColor(.yellow)) novamente")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .minimumScaleFactor(15)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    .onTapGesture(count: 1) {
                        print("toquei")
                    }
                Image("dois dedos")
            }
        }
    }
}

struct DoisDedos_Previews: PreviewProvider {
    static var previews: some View {
        DoisDedos()
    }
}
