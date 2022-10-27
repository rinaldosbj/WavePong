//
//  OnboardingTres.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct ToqueDuas: View {
    
    @State var scale2: CGFloat = 0.35
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                Text("\(Text("Toque duas").foregroundColor(.yellow)) vezes para \(Text("selecionar").foregroundColor(.yellow)) o que deseja ")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .foregroundColor(.white)
                    .bold()
                    .minimumScaleFactor(15)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    .onTapGesture(count: 1) {
                        print("toquei")
                    }
                Image("dois toques")
                    .scaleEffect(scale2)
                    .animation(
                        Animation
                            .easeIn(duration:2)
                            .repeatForever()
                    )
                    .onAppear{
                        self.scale2 += 2
                    }
                
            }
        }.onTapGesture(count: 2, perform: doubleClicked)
    }
    func doubleClicked() {
        print("double clickou")
    }
}

struct ToqueDuas_Previews: PreviewProvider {
    static var previews: some View {
        ToqueDuas()
    }
}
