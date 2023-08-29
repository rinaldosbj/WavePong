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

    
    /// shared instance for global acess to Object
    static var shared = SoundManager()
    
    var player: PlayerProtocol = Player()
    
    /// Responsable for holding the instance of player for background Music
    var musicPlayer: AVAudioPlayer?
    
    /// Responsable for holding the instance of player for  FX Sounds
    var audioPLayer: AVAudioPlayer?
    
    /// Allows adjust method for audio pan
    var panStyle: SoundMode {
        player.soundMode
    }
    
    /// Allows player to estimate ball position by diferance in stereo output
    public func updateAudioOrientation(ballPosition position: CGPoint, frameSize size: CGSize) {
        
        //        let volumeAdjusted = 1.075 - (0.8 *  Float(position.y / size.height))
        //        musicPlayer?.volume = volumeAdjusted
        
        let volumeAdjusted = Float(
            1 - (position.y / (size.height - 60))
        )
        
        musicPlayer?.volume = volumeAdjusted
        
        print(panStyle)
        
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
        
        guard let url = Bundle.main.url(forResource: "WavePong_soundtrack", withExtension: "mp3") else {
            print("arquivo não encontrado")
            return
        }
        
        do {
            musicPlayer = nil
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.numberOfLoops = -1
            musicPlayer?.prepareToPlay()
            musicPlayer?.play()
            
        } catch let error {
            print("Erro ao tentar reproduzir a música: \(error.localizedDescription)")
        }
        
        
    }
    
    // MARK: Game Music
    
    /// Pauses game theme music
    public func pauseGameTheme() {
        musicPlayer?.pause()
    }
    
    
    /// Resumes game theme music
    public func resumeGameTheme() {
        musicPlayer?.play()
    }
    
    /// Stops game Theme Music
    public func stopGameTheme() {
        musicPlayer = nil
        audioPLayer = nil
    }
    
    
    // MARK: FX Sounds
    private func getURLSoundFX(for name: FXSounds) -> URL? {
        switch name{
        case .countDownBip:
            return Bundle.main.url(forResource: name.rawValue, withExtension: "wav")
        case .countDownEnd:
            return Bundle.main.url(forResource: name.rawValue, withExtension: "wav")
        case .explosion:
            return Bundle.main.url(forResource: name.rawValue, withExtension: "wav")
        case .pickupCoin:
            return Bundle.main.url(forResource: name.rawValue, withExtension: "wav")
        default:
            return Bundle.main.url(forResource: name.rawValue, withExtension: "mp3")
        }
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


