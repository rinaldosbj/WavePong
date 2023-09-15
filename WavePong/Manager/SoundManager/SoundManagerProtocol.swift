//
//  SoundManagerProtocol.swift
//  WavePong
//
//  Created by Lucas Migge on 15/09/23.
//

import Foundation

protocol SoundManagerProtocol {
    
    static var shared: SoundManagerProtocol { get }
    
    var player: PlayerProtocol { get }
    
    func updateAudioOrientation(ballPosition position: CGPoint, frameSize size: CGSize)
    
    func playGameTheme()
    
    func pauseGameTheme()
    
    func resumeGameTheme()
    
    func stopGameTheme()
    
    func playFXSound(for name: FXSounds)
    
}
