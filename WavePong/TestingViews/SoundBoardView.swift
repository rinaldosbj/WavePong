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
        VStack {
            Button("Alerta") {
                audioPlayer.playFXSound(for: .alert)
            }
            
            Button("Bounce") {
                audioPlayer.playFXSound(for: .bounce)
            }
            
            Button("Cute Click") {
                audioPlayer.playFXSound(for: .cuteClick)
            }
            
            Button("Failed") {
                audioPlayer.playFXSound(for: .hehe)
            }
            
            Button("Mouse") {
                audioPlayer.playFXSound(for: .mouse)
            }
            
            Button("Surprise") {
                audioPlayer.playFXSound(for: .surprise)
            }
            
            Button("Win") {
                audioPlayer.playFXSound(for: .winzinho)
            }
            
            
        }
        .buttonStyle(.bordered)
    }
}

struct SoundBoardView_Previews: PreviewProvider {
    static var previews: some View {
        SoundBoardView()
    }
}
