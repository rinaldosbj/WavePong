//
//  OnboardingDois.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 26/10/22.
//

import SwiftUI

struct ToqueUma: View {
    
    @State var scale: CGFloat = 1.0
    
    var body: some View {
        
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 60 ){
                Text("\(Text("Toque uma").foregroundColor(.yellow)) vez para \(Text("ouvir").foregroundColor(.yellow)) o que está na tela")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .foregroundColor(.white)
                    .bold()
                    .minimumScaleFactor(15)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    .onTapGesture(count: 1) {
                        print("toquei")
                    }
                
                Image("um toque")
                    .scaleEffect(scale)
                //                .frame(width: 107, height: 107)
                    .animation(
                        Animation
                            .easeIn(duration:2)
                            .repeatForever()
                    )
                    .onAppear{
                        self.scale += 2
                    }
            }
            
            NavigationLink(destination: ToqueDuas()){
                Color(.clear)
            }
        }
        
    }
    
    struct ToqueUma_Previews: PreviewProvider {
        static var previews: some View {
            ToqueUma()
        }
    }
}
