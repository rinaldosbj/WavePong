//
//  OnboardingTres.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct ToqueDuas: View {
    
    @State private var scale: CGFloat = 0.35
    
    
    @State private var shouldShow: Bool = false
  
    var body: some View {
        
        ZStack{
            NavigationLink("",destination: ArrasteDireita() ,isActive: $shouldShow)
            
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
                Image("dois toques")
                    .scaleEffect(scale)
                    .animation(
                        Animation
                            .easeIn(duration:2)
                            .repeatForever()
                    )
                    .onAppear{
                        self.scale += 2
                    }
                
            }
        }.onTapGesture(count: 2, perform: doubleClicked)
    }
    func doubleClicked() {
        shouldShow.toggle()
    }
}

struct ToqueDuas_Previews: PreviewProvider {
    static var previews: some View {
        ToqueDuas()
    }
}
