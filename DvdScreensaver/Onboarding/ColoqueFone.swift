//
//  Onboarding.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 25/10/22.
//

import SwiftUI

struct ColoqueFone: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack{
                    Text("\(Text("Coloque").foregroundColor(.yellow)) o \(Text("fone").foregroundColor(.yellow)) de ouvido, depois \(Text("toque").foregroundColor(.yellow)) na tela para continuar").font(.custom("DaysOne-Regular", size: 35))
                        .foregroundColor(.white)
                        .bold()
                        .minimumScaleFactor(15)
                        .multilineTextAlignment(.center)
                        .padding(40)
                        .onTapGesture(count: 1) {
                            print("toquei")
                        }
                        .padding()
                    
                    Image("fone")
                }
                
                NavigationLink(destination: ToqueUma()){
                    Color(.clear)
                }
            }
        }
    }
}

struct ColoqueFone_Previews: PreviewProvider {
    static var previews: some View {
        ColoqueFone()
    }
}
