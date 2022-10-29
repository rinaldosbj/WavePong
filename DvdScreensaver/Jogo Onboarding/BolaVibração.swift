//
//  BolaVibração.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 29/10/22.
//

import SwiftUI

struct BolaVibrac_a_o: View {
        
        @State var bola = false

        var body: some View {
            
            VStack{
                Spacer()
                    .frame(height:100)
                
                Text("A posição da bola será guiada pela música")
                    .font(.custom("DaysOne-Regular", size: 35))
                        .bold()
                        .frame(width: 310, height: 270, alignment: .center)
//                Spacer()
//                    .frame(height:90)
                
            ZStack(alignment: .center){
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.yellow)
                    .offset(x: bola ? 45: 0, y: bola ? 0: 70)
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


struct BolaVibrac_a_o_Previews: PreviewProvider {
    static var previews: some View {
        BolaVibrac_a_o()
    }
}
