//
//  OnboardingCinco.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct DoisDedos: View {
    
    @State var scale: CGFloat = 1
    
    var body: some View {
        VStack(alignment: .center, spacing: 60){
            Text("Toque com os dois dedos para ouvir as instruções novamente")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding(40)
                    .onTapGesture(count: 1) {
                        print("toquei")
                    }
            HStack{
            Image(systemName: "circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .center)
                .padding(10)
                .blur(radius: scale, opaque: false)
                .foregroundColor(.yellow)
                .overlay(
                    Circle()
                        .stroke(Color.yellow)
                        .blur(radius: scale)
                        .scaleEffect(scale)
                        .opacity(Double(2 - scale))
                        .animation(.easeOut(duration: 2)
                            .repeatForever(autoreverses: false))
                )
                Image(systemName: "circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding(10)
                    .blur(radius: scale, opaque: false)
                    .foregroundColor(.yellow)
                    .overlay(
                        Circle()
                            .stroke(Color.yellow)
                            .blur(radius: scale)
                            .scaleEffect(scale)
                            .opacity(Double(2 - scale))
                            .animation(.easeOut(duration: 2)
                                .repeatForever(autoreverses: false))
                    )
                        .onAppear{
                            self.scale += 1
                        }
        }
    }
}

struct DoisDedos_Previews: PreviewProvider {
    static var previews: some View {
        DoisDedos()
        }
    }
}
