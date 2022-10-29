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
//        ZStack{
//
//            Image("background")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
                
            VStack(alignment: .center){
                
                Spacer()
                    .frame(height:100)
                
                Text("Deslize os dedos para os lados para mover a raquete e rebater a bola")
                    .font(.custom("DaysOne-Regular", size: 35))
                        .bold()
//                        .padding(40)
                        .frame(width: 310, height: 270, alignment: .center)
    //                    .onTapGesture(count: 1) {
    //                        print("toquei")
    //                    }
                
//               Spacer()
//                        .frame(height:)
                
            VStack{
                
                    Spacer()
                
                    Image("raquete")
                        .frame(width: 145, height: 33, alignment: .center)
                        .offset(x: CGFloat(deslize))
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true))
                        .padding(20)

                        .onAppear{
                                deslize = -100
                            }
                    }
                }
            }
        }
//}

struct DeslizeDedo_Previews: PreviewProvider {
    static var previews: some View {
        DeslizeDedo()
    }
}
