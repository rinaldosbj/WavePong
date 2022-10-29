//
//  DeslizeDedos.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 28/10/22.
//

import SwiftUI

struct BolaGuiada: View {
    
    @State var bola = false

    var body: some View {
        
        VStack{
            Spacer()
                .frame(height:100)
            
            Text("A posição da bola será guiada pela música")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .frame(width: 310, height: 270, alignment: .center)
//            Spacer()
//                .frame(height:40)
            
        ZStack(alignment: .leading){
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
//            Image("Ball")
                .offset(x: bola ? 55: 0, y: bola ? 70: 0)
                .animation(.linear(duration: 2)
                    .repeatForever(autoreverses: false))
            
            
            VStack {
                Spacer()

                Image("raquete")
                    .frame(width: 145, height: 33, alignment: .center)
                    .padding(20)

                }

                .onAppear{
                    bola = true
            
            
                }
            }
        }
    }
}

struct BolaGuiada_Previews: PreviewProvider {
    static var previews: some View {
        BolaGuiada()
    }
}
