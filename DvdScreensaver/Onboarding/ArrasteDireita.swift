//
//  ArrasteDireita.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct ArrasteDireita: View {
    
    @State private var shouldShow: Bool = false
  
    var body: some View {
        ZStack{
            NavigationLink("",destination: ArrasteEsquerda().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                Text("\(Text("Arraste").foregroundColor(.yellow)) para os lados para \(Text("navegar").foregroundColor(.yellow)) pelo menu")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .foregroundColor(.white)
                    .bold()
                    .minimumScaleFactor(15)
                    .multilineTextAlignment(.center)
                    .padding(40)
                
                Image("arraste direita")
            }
        }.highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
            .onEnded { value in
                if abs(value.translation.height) < abs(value.translation.width) {
                    if abs(value.translation.width) > 50.0 {
                        if value.translation.width < 0 {
                            self.swipeRightToLeft()
                        } else if value.translation.width > 0 {
                            self.swipeLeftToRight()
                        }
                    }
                }
            }
        )

    }
    func  swipeRightToLeft(){
        shouldShow.toggle()
    }
    func swipeLeftToRight(){
        shouldShow.toggle()
    }
}

struct ArrasteDireita_Previews: PreviewProvider {
    static var previews: some View {
        ArrasteDireita()
    }
}
