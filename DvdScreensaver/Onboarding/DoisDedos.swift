//
//  OnboardingCinco.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI
import AVKit

struct DoisDedos: View {
    @State var audioPlayer: AVAudioPlayer!
    @State private var shouldShow: Bool = false
    let contentView = ContentView()
    @State var scale: CGFloat = 1
    
    var body: some View {
        ZStack{
            if contentView.record >= 1 {
                NavigationLink("",destination: MenuView().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            } else {
                NavigationLink("",destination: DeslizeDedo().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            }
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                
            
            VStack(alignment: .center, spacing: 60){
                Text("\(Text("Clique").foregroundColor(.yellow)) com os \(Text("dois dedos").foregroundColor(.yellow)) para ouvir as \(Text("instruções").foregroundColor(.yellow)) novamente")
                    .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .minimumScaleFactor(15)
                    .foregroundColor(.white)
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
        }.overlay(TappableView{gesture in
            shouldShow.toggle()
            self.audioPlayer.pause()})
        .onAppear {
                let sound = Bundle.main.path(forResource: "onboarding4", ofType: "mp3")
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                self.audioPlayer.play()
        }
    }
}

struct DoisDedos_Previews: PreviewProvider {
    static var previews: some View {
        DoisDedos()
    }
}

