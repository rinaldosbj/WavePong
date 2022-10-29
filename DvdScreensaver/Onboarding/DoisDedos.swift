//
//  OnboardingCinco.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct DoisDedos: View {
    
    @State private var shouldShow: Bool = false
    
    @State var scale: CGFloat = 1
    
    var body: some View {
        ZStack{
            NavigationLink("",destination: ContentView().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            
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

