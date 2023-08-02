//
//  SoundBoardView.swift
//  WavePong
//
//  Created by Lucas Migge on 01/08/23.
//

import SwiftUI

struct SoundBoardView: View {
    
    var audioPlayer = SoundManager.shared
    
    
    var body: some View {
        
        List {
            Section("Game Theme") {
                Button {
                    audioPlayer.playGameTheme()
                }
            label: {
                Image(systemName: audioPlayer.isPlayingTheme ? "pause.fill" : "play.fill")
            }
                
                
                Button {
                    audioPlayer.stopGameTheme()
                } label: {
                    Image(systemName: "stop.fill")
                }
                
            }
            
            
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
        
    }
    
    
}


struct SoundBoardView_Previews: PreviewProvider {
    static var previews: some View {
        SoundBoardView()
    }
}
