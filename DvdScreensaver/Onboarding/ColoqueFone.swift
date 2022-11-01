//
//  Onboarding.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 25/10/22.
//

import SwiftUI
import AVKit

struct ColoqueFone: View {
    @State var audioPlayer: AVAudioPlayer!
    
    @State private var shouldShow: Bool = false
 
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack{
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
                    self.audioPlayer.pause()
                    shouldShow.toggle()
                }
                .onAppear {
                    let sound = Bundle.main.path(forResource: "coloquefone", ofType: "mp3")
                    self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                    self.audioPlayer.play()
                }
            }
        } else {
            // Fallback on earlier versions
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
                    self.audioPlayer.pause()
                    shouldShow.toggle()
                }
                .onAppear {
                    let sound = Bundle.main.path(forResource: "coloquefone", ofType: "mp3")
                    self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                    self.audioPlayer.play()
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
