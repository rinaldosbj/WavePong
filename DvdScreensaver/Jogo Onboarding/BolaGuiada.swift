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
            
            Text("A posição da bola será guiada pelas música")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding(40)
            Spacer()
                .frame(height:90)
            
        ZStack(alignment: .leading){
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
                .offset(x: bola ? 45: 0, y: bola ? 100: 0)
                .animation(.linear(duration: 2)
                    .repeatForever(autoreverses: false))
            
            
            VStack {
                Spacer()

                Image("raquete")
                    .frame(width: 145, height: 33, alignment: .center)
                    
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
