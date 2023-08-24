//
//  GameManager.swift
//  WavePong
//
//  Created by rsbj on 01/08/23.
//

import SpriteKit


/// Object responsable for dealing with game logic
class GameManager {
    /// User Current Score
    var score: Int
    /// Gate for controling if user can pause the game. While in count down it should be false
    var canPause: Bool
    
    /// Instance for calling sounds
    var soundManager: SoundManager
    /// Instance for calling vibrations
    var hapticsManager: HapticsManager
    
    /// Instance of object responsable for dealing with game colision logic
    var physicsDetection: PhysicsDetection
    
    /// Instance for interaction with the gameScene
    weak var sceneDelegate: GameSceneDelegate?
    /// Instantece for interaction with Game Scene View Model
    weak var gameManagerDelegate: GameManagerDelegate?
    
    /// Instance for acessing player preferences and topScore
    var player: PlayerProtocol
    
    init(score: Int = 0,
         canPause: Bool = false,
         soundManager: SoundManager = SoundManager.shared,
         hapticsManager: HapticsManager = HapticsManager.shared,
         physicsDetection: PhysicsDetection = PhysicsDetection(),
         player: PlayerProtocol = Player()
    ) {
        self.score = score
        self.canPause = canPause
        self.soundManager = soundManager
        self.hapticsManager = hapticsManager
        self.physicsDetection = physicsDetection
        self.player = player
    }
    
    /// Changes the state of manager for been able to pause
    ///
    /// Should be Called when Count down of game scene is over
    func canPauseNow() {
        canPause = true
    }
    
    /// Informs Game Scene to start game and implements necesseray logic
    func startGame() {
        sceneDelegate?.startGame()
        soundManager.playGameTheme()
        score = 0
    }
    
    func resumeGame() {
        soundManager.resumeGameTheme()
        sceneDelegate?.resumeGame()
    }
    
    func resetGame() {
        restoreGameManager()
        sceneDelegate?.resetGame()
    }
    
    func restoreGameManager() {
        soundManager.stopGameTheme()
        canPause = false
        score = 0
    }
    
    func pauseButtonPressed() {
        if canPause{
            soundManager.pauseGameTheme()
            sceneDelegate?.pausePressed()
        }
    }
    
    func pauseNodePressed() {
        if canPause{
            soundManager.pauseGameTheme()
            sceneDelegate?.pausePressed()
            gameManagerDelegate?.pauseNodePressed()
        }
        
    }
    
    public func updateAudioOrientation(ballPosition: CGPoint, frameSize: CGSize) {
        soundManager.updateAudioOrientation(ballPosition: ballPosition, frameSize: frameSize)
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
            soundManager.playFXSound(for: .explosion)
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

    
    public func didLose() {
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


