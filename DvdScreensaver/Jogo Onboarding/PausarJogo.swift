//
//  PausarJogo.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 29/10/22.
//

import SwiftUI

struct PausarJogo: View {
    
    @State var scale: CGFloat = 1
    
    @State private var shouldShow: Bool = false
    
    var body: some View {
        
        ZStack{
            
            NavigationLink("",destination: ContentView().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 60){
                Spacer()
                    .frame()
                
                Text("\(Text("Dois toques").foregroundColor(.yellow)) para \(Text("pausar").foregroundColor(.yellow)) o jogo")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 310, height: 270, alignment: .center)
                
                
                
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
                        .onAppear{
                            self.scale += 1
                        }
                }
                VStack(alignment: .center) {
                    
                    Image("raquete")
                        .frame(width: 145, height: 33, alignment: .center)
                    
                    Spacer().frame()
                }
                Spacer().frame()
            }
        }.onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                shouldShow.toggle()
            }
        }
    }
}

struct PausarJogo_Previews: PreviewProvider {
    static var previews: some View {
        PausarJogo()
    }
}
