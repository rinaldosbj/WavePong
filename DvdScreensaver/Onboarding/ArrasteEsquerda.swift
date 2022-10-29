//
//  OnboardingQuatro.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct ArrasteEsquerda: View {
    
    @State var arraste = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 60){
            Text("Arraste para os lados para navegar pelo menu")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding(40)
//                    .onTapGesture(count: 1) {
//                        print("toquei")
//                    }
            ZStack(alignment: .leading){
                
                Capsule()
                    .fill(LinearGradient(gradient: .init(colors: [Color("laranja"),Color("amarelo").opacity(0.30)]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 183, height: 50, alignment: .center)
                    
                
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.yellow)
                    .offset(x: arraste ? 0: 130)
                    .animation(.linear(duration: 2)
                        .repeatForever(autoreverses: false))

                    .onAppear{
                        arraste = true
                    }
            }
        }
    }
}
struct ArrasteEsquerda_Previews: PreviewProvider {
    static var previews: some View {
        ArrasteEsquerda()
    }
}
