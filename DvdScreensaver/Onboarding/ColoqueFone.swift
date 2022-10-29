//
//  Onboarding.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 25/10/22.
//

import SwiftUI

struct ColoqueFone: View {
   
    @State private var shouldShow: Bool = false
 
    var body: some View {
        
        NavigationView{
            ZStack{
                NavigationLink("",destination: ToqueUma().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
                
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
                        .padding()
                    
                    Image("fone")
            }
            }.onTapGesture {
                shouldShow.toggle()
            }
        }
    }
}

struct ColoqueFone_Previews: PreviewProvider {
    static var previews: some View {
        ColoqueFone()
    }
}
