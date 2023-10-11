//
//  GameManagerProtocol.swift
//  WavePong
//
//  Created by Lucas Migge on 29/08/23.
//

import Foundation

/// Protocol where we can decribe the GameManager behavor for testing
protocol GameManagerProtocol: GameColisionDelegate, GameUserFeedbackProtocol {
    
    var gameDifficulty: GameDifficulty { get }
    
    var score: Int { get set }
    
    var gameManagerSetting: GameManagerSettings { get }
        
    var state: GameManager.GameManagerState { get set }
    
    var physicsDetection: PhysicsDetection { get }
    
    var sceneDelegate: GameSceneDelegate? { get set }
    
    var gameManagerDelegate: GameManagerDelegate? { get set }
    
    var player: PlayerProtocol { get }
    
    func startGame()
    
    func updateGameScene(nodes: UpdatableSceneNodes, ballVelocityCorrected: @escaping (CGVector) -> Void)
    
    func resumeGame()
    
    func resetGame()
    
    func pauseNodePressed()
    
    func pauseTrigger()
    
    
    func countDownStep()
    
    func countDownEnded()
}

protocol GameUserFeedbackProtocol {
//    var soundManager: SoundManagerProtocol { get set }
//    
//    var hapticsManager: HapticsManagerProtocol { get set }
    
}
