//
//  SoundManager.swift
//  WavePong
//
//  Created by Lucas Migge on 31/07/23.
//

import Foundation
import AVFoundation


/// Object responsable for managing sounds and music of APP
public class SoundManager: SoundManagerProtocol {
    
    var soundKit: SoundKit?
    
    /// shared instance for global acess to Object
    static var shared: SoundManagerProtocol = SoundManager()
    
    internal var player: PlayerProtocol
    internal var avAudioPlayerFactory: AVAudioPlayerFactoryProtocol
    
    init(player: PlayerProtocol = Player(),
         aVAudioPlayerFactory: AVAudioPlayerFactoryProtocol = AVAudioPlayerFactory()
         
    ) {
        self.player = player
        self.avAudioPlayerFactory = aVAudioPlayerFactory
    }
    
    /// Responsable for holding the instance of player for background Music
    internal var musicPlayer: AVAudioPlayerable?
    
    /// Responsable for holding the instance of player for  FX Sounds
    internal var audioPLayer: AVAudioPlayerable?
    
    /// Allows adjust method for audio pan
    var panStyle: SoundMode {
        player.soundMode
    }
    
    /// Allows player to estimate ball position by diferance in stereo output
    public func updateAudioOrientation(ballPosition position: CGPoint, frameSize size: CGSize) {
        
        let volumeAdjusted = Float(
            1 - (position.y / (size.height - 130))
        )
        
        musicPlayer?.volume = volumeAdjusted
        
        switch panStyle {
        case .curved:
            let proportion = Float(position.x / size.width)
            let curvedProportion = sigmoidCurve(proportion)
            
            musicPlayer?.pan = curvedProportion
            
        case .linear:
            let proportion = Float((position.x - (size.width / 2) ) / (size.width/2))
            musicPlayer?.pan = proportion
            audioPLayer?.pan = proportion
            
        case .highContrast:
            // need some work
            var proportion = Float((position.x - (size.width / 2) ) / (size.width/2))
            
            if proportion >= 0.33 {
                proportion = 1
            }
            else if proportion <= -0.33 {
                proportion = -1
            }
            else {
                proportion = 0
            }
            
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
        
        
        musicPlayer = nil
        musicPlayer = avAudioPlayerFactory.creatAVAudioPlayer(contentsOf: url)
        //            musicPlayer = try AVAudioPlayer(contentsOf: url)
        musicPlayer?.numberOfLoops = -1
        _ = musicPlayer?.prepareToPlay()
        _ = musicPlayer?.play()
        
        
        
        
    }
    
    // MARK: Game Music
    
    /// Pauses game theme music
    public func pauseGameTheme() {
        musicPlayer?.pause()
    }
    
    
    /// Resumes game theme music
    public func resumeGameTheme() {
        _ = musicPlayer?.play()
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
        
        
        audioPLayer = avAudioPlayerFactory.creatAVAudioPlayer(contentsOf: url)
        _ = audioPLayer?.play()
        
        
    }
    
}

enum gameSounds {
    case win, lose, record, hit
}

