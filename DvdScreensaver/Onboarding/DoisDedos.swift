//
//  OnboardingCinco.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct DoisDedos: View {
    
    @State private var shouldShow: Bool = false
    
    var body: some View {
        ZStack{
            NavigationLink("",destination: ContentView() ,isActive: $shouldShow)
            
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

                Image("dois dedos")
            }
        }.onTapGesture {
            shouldShow.toggle()
        }
    }
}

struct DoisDedos_Previews: PreviewProvider {
    static var previews: some View {
        DoisDedos()
    }
}
