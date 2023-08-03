//
//  SoundManager.swift
//  WavePong
//
//  Created by Lucas Migge on 31/07/23.
//

import Foundation
import AVFoundation


/// Object responsable for managing sounds and music of APP
public class SoundManager {
    
    /// shared instance for global acess to Object
    static var shared = SoundManager()
    
    /// Responsable for holding the instance of player for background Music
    var musicPlayer: AVAudioPlayer?
    /// Responsable for holding the instance of player for  FX Sounds
    var audioPLayer: AVAudioPlayer?
    
    var isPlayingTheme: Bool = false
    
    /// Allows player to estimate ball position by diferance in stereo output
    public func updateAudioOrientation(ballPosition position: CGPoint, frameSize size: CGSize) {
        let proportion = Float(position.x / size.width)
        let curvedProportion = sigmoidCurve(proportion)
        musicPlayer?.pan = curvedProportion
        audioPLayer?.pan = curvedProportion
    }
    
    private func sigmoidCurve(_ x: Float) -> Float {
        return Float(
            pow((x - 0.5), 3) / 0.0675)
    }
    
    /// Plays background music
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
    
    public func pauseGameTheme() {
        musicPlayer?.pause()
        isPlayingTheme = false
    }
    
    public func resumeGameTheme() {
        musicPlayer?.play()
        isPlayingTheme = true
    }
    
    public func stopGameTheme() {
        musicPlayer = nil
        isPlayingTheme = false
    }
    
    private func getURLSoundFX(for name: FXSounds) -> URL? {
        var url: URL?
        
        switch name {
        case .alert:
            url = Bundle.main.url(forResource: "alert", withExtension: "mp3")
        case .bounce:
            url = Bundle.main.url(forResource: "bounce", withExtension: "mp3")
        case .cuteClick:
            url = Bundle.main.url(forResource: "cuteClick", withExtension: "mp3")
        case .falied:
            url = Bundle.main.url(forResource: "failed", withExtension: "mp3")
        case .hehe:
            url = Bundle.main.url(forResource: "hehe", withExtension: "mp3")
        case .mouse:
            url = Bundle.main.url(forResource: "mouse", withExtension: "mp3")
        case .surprise:
            url = Bundle.main.url(forResource: "surprise", withExtension: "mp3")
        case .winzinho:
            url = Bundle.main.url(forResource: "winzinho", withExtension: "mp3")
        }
        
        return url
    }
    
    /// Play a FX Sound for a given type
    public func playFXSound(for name: FXSounds) {
        
        guard let url = getURLSoundFX(for: name) else {
            print("arquivo fx não encontrado")
            return
        }
        
        do {
            audioPLayer = try AVAudioPlayer(contentsOf: url)
            audioPLayer?.play()
        } catch let error {
            print("Erro ao reproduzir fx: \(error.localizedDescription)")
        }
        
        
    }
    
}


