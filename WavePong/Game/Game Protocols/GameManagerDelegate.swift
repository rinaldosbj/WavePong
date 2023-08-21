//
//  PauseButtonDelegate.swift
//  WavePong
//
//  Created by Lucas Migge on 14/08/23.
//

import Foundation

/// Protocol for informing event from gameLogic
///
/// When using a gameScene from SpriteKit, you may need inform a view for changes in the game state. This protocols should be used for notifing view when game is paused or when it's over
protocol GameManagerDelegate {
    
    /// Once game should be paused, the methods sould be used for implementing view changes
    func pauseButtonPressed()
    
    func gameOver(scoreLabel: String, recordLabel: String)
    
}

