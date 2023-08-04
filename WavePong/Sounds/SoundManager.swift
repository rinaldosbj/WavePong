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
    
    /// Linear or curved gives diferent experience when estimating ball position. Curved is recomended
    enum PanStyle {
        case linear, curved
    }
    
    /// shared instance for global acess to Object
    static var shared = SoundManager()
    
    /// Responsable for holding the instance of player for background Music
    var musicPlayer: AVAudioPlayer?
    
    /// Responsable for holding the instance of player for  FX Sounds
    var audioPLayer: AVAudioPlayer?
    
    var isPlayingTheme: Bool = false
    
    /// Allows adjust method for audio pan
    var panStyle: PanStyle = .curved
    
    /// Allows player to estimate ball position by diferance in stereo output
    public func updateAudioOrientation(ballPosition position: CGPoint, frameSize size: CGSize) {
        
        let volumeAdjusted = 1.075 - (0.8 *  Float(position.y / size.height))
        musicPlayer?.volume = volumeAdjusted

        switch panStyle {
        case .curved:
            let proportion = Float(position.x / size.width)
            let curvedProportion = sigmoidCurve(proportion)
            
            musicPlayer?.pan = curvedProportion
            
        case .linear:
            let proportion = Float((position.x - (size.width / 2) ) / size.width)
            musicPlayer?.pan = proportion
            audioPLayer?.pan = proportion
            
        }
        
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
    
    // MARK: Game Music
    
    /// Pauses game theme music
    public func pauseGameTheme() {
        musicPlayer?.pause()
        isPlayingTheme = false
    }
    
    
    /// Resumes game theme music
    public func resumeGameTheme() {
        musicPlayer?.play()
        isPlayingTheme = true
    }
    
    /// Stops game Theme Music
    public func stopGameTheme() {
        musicPlayer = nil
        isPlayingTheme = false
    }
    
    
    // MARK: FX Sounds
    private func getURLSoundFX(for name: FXSounds) -> URL? {
        return Bundle.main.url(forResource: name.rawValue, withExtension: "mp3")
        
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
            print("funcionou")
        } catch let error {
            print("Erro ao reproduzir fx: \(error.localizedDescription)")
        }
        
        
    }
    
}


