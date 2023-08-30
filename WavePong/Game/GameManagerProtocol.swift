//
//  GameManagerProtocol.swift
//  WavePong
//
//  Created by Lucas Migge on 29/08/23.
//

import Foundation

protocol GameManagerProtocol: GameColisionDelegate {
    var score: Int { get set }
    
    var canPause: Bool { get set }
    
    var soundManager: SoundManagerProtocol { get set }
    
    var hapticsManager: HapticsManagerProtocol { get set }
    
    var physicsDetection: PhysicsDetection { get }
    
    var sceneDelegate: GameSceneDelegate? { get set }
    
    var gameManagerDelegate: GameManagerDelegate? { get set }
    
    var player: PlayerProtocol { get }
    
    func countDownDone()
    
    func startGame()
    
    func resumeGame()
    
    func resetGame()
    
    func pauseNodePressed()
    
    func pauseButtonPressed()
    
    func updateAudioOrientation(ballPosition: CGPoint, frameSize: CGSize)
    
    func countDownStep()
    
    func countDownEnded()
}
