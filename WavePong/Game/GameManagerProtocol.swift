//
//  GameManagerProtocol.swift
//  WavePong
//
//  Created by Lucas Migge on 29/08/23.
//

import Foundation

protocol GameManagerProtocol: GameColisionDelegate, GameUserFeedbackProtocol {
    
    var gameDificulty: GameDifficulty { get }
    
    var score: Int { get set }
    
    var gameManagerSetting: gameManagerSettings { get }
        
    var state: GameManager.GameManagerState { get set }
    
    var physicsDetection: PhysicsDetection { get }
    
    var sceneDelegate: GameSceneDelegate? { get set }
    
    var gameManagerDelegate: GameManagerDelegate? { get set }
    
    var player: PlayerProtocol { get }
    
    func startGame()
    
    func incrementBallSpeed()
    
    func correctedBallSpeed(for velocity: CGFloat) -> CGFloat
    
    func resumeGame()
    
    func resetGame()
    
    func pauseNodePressed()
    
    func pauseButtonPressed()
    
    func updateAudioOrientation(ballPosition: CGPoint, frameSize: CGSize)
    
    func countDownStep()
    
    func countDownEnded()
}

protocol GameUserFeedbackProtocol {
    var soundManager: SoundManagerProtocol { get set }
    
    var hapticsManager: HapticsManagerProtocol { get set }
    
}
