//
//  OnboardingQuatro.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct ArrasteEsquerda: View {
    
    @State var arraste = 100
    
    var body: some View {
        VStack(alignment: .center, spacing: 60){
            Text("Arraste para os lados para navegar pelo menu")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding(40)
//                    .onTapGesture(count: 1) {
//                        print("toquei")
//                    }
            ZStack(alignment: .center){
                
//                Capsule()
//                    .fill(LinearGradient(gradient: .init(colors: [Color("laranja"),Color("amarelo").opacity(0.30)]), startPoint: .leading, endPoint: .trailing))
//                    .frame(width: 183, height: 50, alignment: .center)
                    
                
                
                Circle()
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(.yellow)
                    .offset(x: CGFloat(arraste))
                    .animation(.easeInOut(duration: 2)
                        .repeatForever(autoreverses: true))

                    .onAppear{
                        arraste = -100
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
