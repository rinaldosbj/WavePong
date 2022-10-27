//
//  ArrasteDireita.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct ArrasteDireita: View {
    
    @State var scale3: CGFloat = 0.35
    
    var body: some View {
        ZStack{
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
                    .onTapGesture(count: 1) {
                        print("toquei")
                    }
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
        print("swipou pra esquerda")
    }
    func swipeLeftToRight(){
        print("swipou pra direita")
    }
}

struct ArrasteDireita_Previews: PreviewProvider {
    static var previews: some View {
        ArrasteDireita()
    }
}
