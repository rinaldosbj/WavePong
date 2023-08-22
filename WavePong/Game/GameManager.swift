//
//  GameManager.swift
//  WavePong
//
//  Created by rsbj on 01/08/23.
//

import SpriteKit


/// Object responsable for dealing with game logic
class GameManager {
    var isGameRunning: Bool = true
    var score: Int = 0
    
    var soundManager: SoundManager = SoundManager.shared
    var hapticsManager: HapticsManager = HapticsManager.shared
    
    var physicsDetection = PhysicsDetection()
    var sceneDelegate: GameSceneDelegate?
    var gameManagerDelegate: GameManagerDelegate?
    
    var player: PlayerProtocol = Player()
    
    public var colors: [UIColor] = [UIColor.blue,UIColor.cyan,UIColor.green]
    
    init() {
        self.physicsDetection.gameActionDelegate = self
        
    }
    
    func startGame() {
        sceneDelegate?.startGame()
        soundManager.playGameTheme()
        score = 0
    }
    
    func resumeGame() {
        sceneDelegate?.resumeGame()
    }
    
    func pauseButtonPressed() {
        soundManager.pauseGameTheme()
        sceneDelegate?.pausePressed()
        gameManagerDelegate?.pauseButtonPressed()
    }
    
    
}

extension GameManager: GameColisionDelegate {
    
    private var isNewRecord: Bool {
        score > player.userTopScore
    }
    
    
    private enum UserNotificationGameEventType {
        case scored, newTopScore, gameOver
    }
    
    private func notifyUserOfEvent(_ event: UserNotificationGameEventType) {
        switch event {
        case .scored:
            soundManager.playFXSound(for: .shooting)
            hapticsManager.vibrateNotification(for: .success)
        case .gameOver:
            soundManager.playFXSound(for: .slimejump)
            hapticsManager.vibrateNotification(for: .error)
        case .newTopScore:
            soundManager.playFXSound(for: .winzinho)
            hapticsManager.vibrateNotification(for: .success)
        }
    }
    
    
    public func incrementScore(){
        score += 1
        notifyUserOfEvent(.scored)
        sceneDelegate?.UserScored(newScore: score)
        
    }
    
    public func didExit() {
        isGameRunning = false
        soundManager.pauseGameTheme()
        
        if isNewRecord {
            player.updateTopScore(NewTopScore: score)
            gameManagerDelegate?.gameOver(scoreLabel: "\(score)",
                                          recordLabel: "Novo recorde")
        } else {
            var topScore: Int {
                Player.shared.userTopScore
            }
            gameManagerDelegate?.gameOver(scoreLabel: "\(score)",
                                          recordLabel: "Recorde \(topScore)")
        }
        
        sceneDelegate?.gameOver()
    }
    
    public func didLose() {
        isGameRunning = false
        soundManager.pauseGameTheme()
        
        if isNewRecord {
            notifyUserOfEvent(.newTopScore)
            player.updateTopScore(NewTopScore: score)
            gameManagerDelegate?.gameOver(scoreLabel: "\(score)",
                                          recordLabel: "Novo recorde")
        } else {
            notifyUserOfEvent(.gameOver)
            var topScore: Int {
                Player.shared.userTopScore
            }
            gameManagerDelegate?.gameOver(scoreLabel: "\(score)",
                                          recordLabel: "Recorde \(topScore)")
        }
        
        sceneDelegate?.gameOver()
        
    }
    
    
    
}


