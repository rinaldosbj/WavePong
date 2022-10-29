//
//  BolaGuiada.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 28/10/22.
//

import SwiftUI

struct DeslizeDedo: View {
    
    @State var deslize = 100

    
    var body: some View {
                
        VStack(alignment: .center){
            
            Spacer()
                .frame(height:130)
            
            Text("Deslize os dedos para os lados para mover a raquete e rebater a bola")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding(40)
//                    .onTapGesture(count: 1) {
//                        print("toquei")
//                    }
            
           Spacer()
                    .frame(height:250)
            
        HStack{
            
                Image("raquete")
                    .frame(width: 145, height: 33, alignment: .center)
                    .offset(x: CGFloat(deslize))
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true))

                    .onAppear{
                            deslize = -100
                        }
               }
        }
    }
}

struct DeslizeDedo_Previews: PreviewProvider {
    static var previews: some View {
        DeslizeDedo()
    }
}
