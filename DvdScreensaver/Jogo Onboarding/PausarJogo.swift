//
//  PausarJogo.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 29/10/22.
//

import SwiftUI

struct PausarJogo: View {
    
    @State var scale: CGFloat = 1
    
    var body: some View {
        VStack(alignment: .center, spacing: 60){
            Spacer()
                .frame(height: 100)
            
            Text("Toque com os dois dedos para pausar o jogo")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding(40)
                    .onTapGesture(count: 1) {
                        print("toquei")
                    }
            
            Spacer()
                .frame(height: 5)



            HStack(alignment: .center){
                
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
                            .blur(radius: scale)
                            .scaleEffect(scale)
                            .opacity(Double(2 - scale))
                            .animation(.easeOut(duration: 2)
                                .repeatForever(autoreverses: false))
                )
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
                            .blur(radius: scale)
                            .scaleEffect(scale)
                            .opacity(Double(2 - scale))
                            .animation(.easeOut(duration: 2)
                                .repeatForever(autoreverses: false))
                    )
                        .onAppear{
                            self.scale += 1
                        }
            }
            VStack(alignment: .center) {
                Spacer()
                    .frame(height: 100)
                
                Image("raquete")
                    .frame(width: 145, height: 33, alignment: .center)
                }
        }
    }
}

struct PausarJogo_Previews: PreviewProvider {
    static var previews: some View {
        PausarJogo()
    }
}
