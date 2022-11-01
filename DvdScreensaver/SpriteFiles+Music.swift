//
//  SpriteFiles+Music.swift
//  DvdScreensaver
//
//  Created by rsbj on 01/11/22.
//

import SpriteKit
import AVFoundation
import SwiftUI

extension PongScene{
    
    func Music() {
        // Audio System
        if let tocador = tocador, tocador.isPlaying && moveTransformBall.tx != 0 {
            if ballPositionX/self.frame.maxX >= 0 {
                tocador.pan = Float((ballPositionX - self.frame.midX)/self.frame.midX) // -1 -> 1
                tocador.volume = Float(1 - (ballPositionY/(self.frame.height - 60))) // alto 0 -> baixo 1
            }
        }
        
        else if moveTransformBall.tx != 0{
            let urlString = Bundle.main.path(forResource: "soundtrack", ofType: "mp3")// defining the song
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true,options: .notifyOthersOnDeactivation)
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: .duckOthers) // Makes audio play in silent mode
                guard let urlString = urlString else {
                    return
                }
                tocador = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                guard let tocador = tocador else { // unraping
                    return
                }
                tocador.play()
            }
            catch{
                print("Deu erro ae mané: \(error.localizedDescription)")
            }
        }
    }
}
