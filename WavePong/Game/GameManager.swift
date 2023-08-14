//
//  GameManager.swift
//  WavePong
//
//  Created by rsbj on 01/08/23.
//

import SpriteKit

protocol PauseNodeDelegate {
    func pauseButtonPressed()
    
    
}



/// Object responsable for dealing if game logic
class GameManager {
    var isGameRunning: Bool = true
    var score: Int = 0
    
    var soundManager: SoundManager = SoundManager.shared
    var hapticsManager: HapticsManager = HapticsManager.shared
    
    var physicsDetection = PhysicsDetection()
    var sceneDelegate: GameSceneProtocol?
    var pauseButtonDelegate: PauseNodeDelegate?
    
    var player: PlayerProtocol = Player()
    
    public var colors: [UIColor] = [UIColor.blue,UIColor.cyan,UIColor.green]
    
    init() {
        self.physicsDetection.gameActionDelegate = self
        soundManager.playGameTheme()
        
    }
    
    func pauseButtonPressed() {
        soundManager.pauseGameTheme()
        sceneDelegate?.pausePressed()
        pauseButtonDelegate?.pauseButtonPressed()
    }
    
    
}

extension GameManager: GameActionDelegate {
    
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
        sceneDelegate?.didUserScored(newScore: score)
        
    }
    
    
    public func didLose() {
        isGameRunning = false
        soundManager.pauseGameTheme()
        
        if isNewRecord {
            notifyUserOfEvent(.newTopScore)
            player.updateTopScore(NewTopScore: score)
        } else {
            notifyUserOfEvent(.gameOver)
        }
        
        sceneDelegate?.gameOver()
        
    }
    
    
    
}


