//
//  DeslizeDedos.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 28/10/22.
//

import SwiftUI
import AVFoundation

struct BolaGuiada: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var bola = false
    
    @State private var shouldShow: Bool = false
    
    var body: some View {
        ZStack{
            NavigationLink("",destination: BolaVibrac_a_o().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                Spacer().frame()
                
                Text("A \(Text("posição").foregroundColor(.yellow)) da bola será \(Text("guiada").foregroundColor(.yellow)) pela música")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 310, height: 270, alignment: .center)
                Spacer().frame()
                
                ZStack(alignment: .center){
                    VStack{
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.yellow)
                        //            Image("Ball")
                            .offset(x: bola ? 55: 0, y: bola ? 60: 0)
                            .animation(.linear(duration: 2)
                                .repeatForever(autoreverses: false))
                        Spacer().frame()
                    }
                    
                    VStack {
                        Spacer().frame()
                        Image("raquete")
                            .scaledToFill()
                            .frame(width: 145, height: 33, alignment: .center)
                            .padding(.top, 100)
                        
                    }
                    .onAppear{
                        bola = true
                        
                        
                    }
                }
                Spacer().frame()
            }
        }.onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                shouldShow.toggle()
            }
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "onboardingjogo2", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.play()
        }
    }
}

struct BolaGuiada_Previews: PreviewProvider {
    static var previews: some View {
        BolaGuiada()
    }
}
