//
//  OnboardingDois.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 26/10/22.
//

import SwiftUI
import AVKit

struct ToqueUma: View {
    @State var audioPlayer: AVAudioPlayer!
    @State private var scale: CGFloat = 1.0
    
    @State private var shouldShow: Bool = false
    
    var body: some View {
        
        ZStack{
            NavigationLink("",destination: ToqueDuas().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 60 ){
                Text("\(Text("Toque uma").foregroundColor(.yellow)) vez para \(Text("ouvir").foregroundColor(.yellow)) o que está na tela")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .foregroundColor(.white)
                    .bold()
                    .minimumScaleFactor(15)
                    .multilineTextAlignment(.center)
                    .padding(40)
                
                HStack{
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
            }
        }.onTapGesture {
            self.audioPlayer.pause()
            shouldShow.toggle()
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "onboarding1", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.play()
        }
    }
}

struct ToqueUma_Previews: PreviewProvider {
    static var previews: some View {
        ToqueUma()
    }
}
