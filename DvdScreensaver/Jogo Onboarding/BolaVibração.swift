//
//  BolaVibração.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 29/10/22.
//

import SwiftUI
import AVFoundation

struct BolaVibrac_a_o: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var bola = false
    
    @State private var shouldShow: Bool = false
    
    var body: some View {
        
        ZStack{
            
            NavigationLink("",destination: ContentView().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                Spacer().frame()
                
                Text("Ao \(Text("rebater").foregroundColor(.yellow)) a bola haverá uma \(Text("vibração").foregroundColor(.yellow))")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 310, height: 270, alignment: .center)
                Spacer().frame()
                
                VStack(alignment: .center){

                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.yellow)
                            .offset(x: bola ? 55: 0, y: bola ? -30 : 30)
                            .animation(.linear(duration: 2)
                                .repeatForever(autoreverses: false))
                        Spacer().frame()
                        
                        Image("raquete")
                            .frame(width: 145, height: 33, alignment: .center)
                            .padding(20)
                        Spacer().frame()
                    .onAppear{
                        bola = true
                    }
                }
                Spacer().frame()
            }
        }.onAppear(){
            UIDevice.vibrate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                shouldShow.toggle()
            }
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "onboardingjogo3", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.play()
        }
    }
}


struct BolaVibrac_a_o_Previews: PreviewProvider {
    static var previews: some View {
        BolaVibrac_a_o()
    }
}
