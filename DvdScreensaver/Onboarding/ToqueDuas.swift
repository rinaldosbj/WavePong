//
//  OnboardingTres.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct ToqueDuas: View {
    @State private var shouldShow: Bool = false
  
    
    @State var scale: CGFloat = 1
    
    var body: some View {
        
        ZStack{
            NavigationLink("",destination: ArrasteDireita().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            
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
                        .frame(width: 80, height: 80, alignment: .center)
                        .blur(radius: scale)
                        .scaleEffect(scale)
                        .opacity(Double(2 - scale))
                        .animation(.easeOut(duration: 2)
                            .repeatForever(autoreverses: false))
                )
                .overlay(
                    Circle()
                        .stroke(Color.yellow)
                        .frame(width: 60, height: 60, alignment: .center)                        .blur(radius: scale)
                        .scaleEffect(scale)
                        .opacity(Double(2 - scale))
                        .animation(.easeOut(duration: 2)
                            .repeatForever(autoreverses: false))
                )
                
                .onAppear{
                    self.scale += 1
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
