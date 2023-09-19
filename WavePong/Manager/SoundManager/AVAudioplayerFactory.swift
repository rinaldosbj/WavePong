//
//  AVAudioplayerFactory.swift
//  WavePong
//
//  Created by Lucas Migge on 15/09/23.
//

import Foundation
import AVFoundation


class AVAudioPlayerFactory: AVAudioPlayerFactoryProtocol {
    func creatAVAudioPlayer(contentsOf url: URL) -> AVAudioPlayerable? {
        return try? AVAudioPlayer(contentsOf: url)
    }
}

protocol AVAudioPlayerFactoryProtocol {
    func creatAVAudioPlayer(contentsOf url: URL) -> AVAudioPlayerable?
}
