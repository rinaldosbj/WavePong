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
        VStack(alignment: .center, spacing: 60 ){
            Text("Toque uma vez para ouvir o que está na tela")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding()
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
                    self.scale += 1
                }
                
    }

}

struct ToqueUma_Previews: PreviewProvider {
    static var previews: some View {
        ToqueUma()
    }
}
}
