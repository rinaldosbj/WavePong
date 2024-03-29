//
//  AVAudioPlayer.swift
//  WavePong
//
//  Created by Lucas Migge on 15/09/23.
//

import AVFoundation


protocol AVAudioPlayerable {
    
    init(contentsOf url: URL) throws
    
    var volume: Float { get set }
    
    var pan: Float { get set }
    
    var numberOfLoops: Int { get set }
    
    func prepareToPlay() -> Bool
    
    func play() -> Bool
    
    func pause()
}

extension AVAudioPlayer: AVAudioPlayerable {
    
}
