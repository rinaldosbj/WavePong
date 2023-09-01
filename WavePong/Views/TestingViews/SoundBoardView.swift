//
//  SoundBoardView.swift
//  WavePong
//
//  Created by Lucas Migge on 01/08/23.
//

import SwiftUI

struct SoundBoardView: View {
    
    var audioPlayer = SoundManager.shared
    @State var sliderValue: CGFloat = 0.5

    var body: some View {
        ZStack {
            Image("backgroundGame")
                .resizable()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            List {

                gameThemeView
                
                fxSoundsView
                
                hapticsNotificationView
                
                hapticsNotificationImpactView
  
            }

        }
        
        .listRowBackground(Color(.clear))
        .listItemTint(.clear)
        
    }
    
    
    
    private var gameThemeView: some View {
        Section("Game Theme") {
//            Button {
//                audioPlayer.playGameTheme()
//            }
//        label: {
//            Image(systemName: audioPlayer.shouldPlay ? "pause.fill" : "play.fill")
//        }
            
            
            Button {
                audioPlayer.stopGameTheme()
            } label: {
                Image(systemName: "stop.fill")
            }
            
        }
    }
    
    private var fxSoundsView: some View {
        Section("FX Sounds") {
            ForEach(FXSounds.allCases, id: \.self) {
                sound in
                
                Button {
                    audioPlayer.playFXSound(for: sound)
                } label: {
                    HStack {
                        Text(sound.rawValue)
                        
                        Spacer()
                        
                        Image(systemName: "speaker.wave.3")
                    }
                    
                }
                
            }
            
        }
        
    }
    
    private var hapticsNotificationView: some View {
        Section("Haptics Notification") {
            
            Button("Standard") {
                HapticsManager.shared.vibrate()
            }
            
            Button("success") {
                HapticsManager.shared.vibrateNotification(for: .success)
            }
            
            Button("Error") {
                HapticsManager.shared.vibrateNotification(for: .error)
            }
            
            Button("Warning") {
                HapticsManager.shared.vibrateNotification(for: .warning)
            }
            

        }
    }
    
    private var hapticsNotificationImpactView: some View {
        
        Section("Haptics Impact") {
            Slider(value: $sliderValue, in: 0...1)
            Button("Soft") {
                HapticsManager.shared.vibrateImpact(for: .soft, intensity: sliderValue)
            }
            Button("Light") {
                HapticsManager.shared.vibrateImpact(for: .light, intensity: sliderValue)
            }
            Button("Medium") {
                HapticsManager.shared.vibrateImpact(for: .medium, intensity: sliderValue)
            }
            Button("Rigid") {
                HapticsManager.shared.vibrateImpact(for: .rigid, intensity: sliderValue)
            }
            Button("Heavy") {
                HapticsManager.shared.vibrateImpact(for: .heavy, intensity: sliderValue)
            }
            
        }
        
    }
    
    
}


struct SoundBoardView_Previews: PreviewProvider {
    static var previews: some View {
        SoundBoardView()
    }
}
