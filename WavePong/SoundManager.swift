//
//  SoundManager.swift
//  WavePong
//
//  Created by Lucas Migge on 31/07/23.
//

import Foundation
import AVFoundation


public class SoundManager {
    
    static var shared = SoundManager()
    
    var musicPlayer: AVAudioPlayer?
    var isPlayingTheme: Bool = false
    
    public func updateAudioOrientation(ballPosition position: CGPoint, frameSize size: CGSize) {
        let proportion = Float(position.x / size.width)
        let curvedProportion = sigmoidCurve(proportion)
//        print("proportion: \(proportion) --- curved: \(curvedProportion)")
        musicPlayer?.pan = curvedProportion
    }
    
    private func sigmoidCurve(_ x: Float) -> Float {
        return Float(
            pow((x - 0.5), 3) / 0.0675)
    }
    
    public func playGameTheme() {
        if !isPlayingTheme {
            
            guard let url = Bundle.main.url(forResource: "WavePong_soundtrack", withExtension: "mp3") else {
                print("arquivo não encontrado")
                return
            }
            
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: url)
                musicPlayer?.numberOfLoops = -1
                musicPlayer?.prepareToPlay()
                musicPlayer?.play()
                isPlayingTheme = true
                
            } catch let error {
                print("Erro ao tentar reproduzir a música: \(error.localizedDescription)")
            }
            
        }
        
        
    }
    
    
    
}
