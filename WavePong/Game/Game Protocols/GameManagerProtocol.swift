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
    
    func getCurrentBall() -> String 
    
    func startGame()
    
    func updateGameScene(frameSize: CGSize,
                         ballPosition: CGPoint?,
                         ballVelocity: CGVector?,
                         ballVelocityCorrected: @escaping (CGVector) -> Void)
    
    func resumeGame()
    
    func resetGame()
    
    func pauseNodePressed()
    
    func pauseTrigger()
    
    
    func countDownStep()
    
    func countDownEnded()
}

protocol GameUserFeedbackProtocol {
    var soundManager: SoundManagerProtocol { get set }
    
    var hapticsManager: HapticsManagerProtocol { get set }
    
}
