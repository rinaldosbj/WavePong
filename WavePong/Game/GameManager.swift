//
//  GameManager.swift
//  WavePong
//
//  Created by rsbj on 01/08/23.
//

import SpriteKit


/// Object responsable for dealing with game logic
class GameManager: GameManagerProtocol {
    
    enum GameManagerState {
        case InContDown, playing
    }
    
    public var state: GameManagerState
    
    /// User Current Score
    public var score: Int
    
    /// Instance for calling sounds
    internal var soundManager: SoundManagerProtocol
    /// Instance for calling vibrations
    internal var hapticsManager: HapticsManagerProtocol
    
    /// Instance of object responsable for dealing with game colision logic
    internal var physicsDetection: PhysicsDetection
    
    /// Instance for interaction with the gameScene
    weak var sceneDelegate: GameSceneDelegate?
    /// Instantece for interaction with Game Scene View Model
    weak var gameManagerDelegate: GameManagerDelegate?
    
    /// Instance for acessing player preferences and topScore
    internal var player: PlayerProtocol
    
    /// Gate for controling if user can pause the game. While in count down it should be false
    internal var canPause: Bool {
        if state == .playing {
            return true
        } else {
            return false
        }
    }
    
    init(score: Int = 0,
         state: GameManagerState = .InContDown,
         soundManager: SoundManagerProtocol = SoundManager.shared,
         hapticsManager: HapticsManagerProtocol = HapticsManager.shared,
         physicsDetection: PhysicsDetection = PhysicsDetection(),
         player: PlayerProtocol = Player()
    ) {
        self.score = score
        self.state = state
        self.soundManager = soundManager
        self.hapticsManager = hapticsManager
        self.physicsDetection = physicsDetection
        self.player = player
        
        self.physicsDetection.gameActionDelegate = self
    }
    
    /// Informs Game Scene to start game and implements necesseray logic
    public func startGame() {
        sceneDelegate?.startGame()
        soundManager.playGameTheme()
        score = 0
    }
    
    public func resumeGame() {
        soundManager.resumeGameTheme()
        sceneDelegate?.resumeGame()
    }
    
    public func resetGame() {
        restoreGameManager()
        sceneDelegate?.resetGame()
    }
    
    public func restoreGameManager() {
        soundManager.stopGameTheme()
        state = .InContDown
        score = 0
    }
    
    public func pauseButtonPressed() {
        if canPause {
            soundManager.pauseGameTheme()
            sceneDelegate?.pausePressed()
        }
    }
    
    public func pauseNodePressed() {
        if canPause {
            soundManager.pauseGameTheme()
            sceneDelegate?.pausePressed()
            gameManagerDelegate?.pauseNodePressed()
        }
        
    }
    
    public func updateAudioOrientation(ballPosition: CGPoint, frameSize: CGSize) {
        soundManager.updateAudioOrientation(ballPosition: ballPosition, frameSize: frameSize)
    }
    
    public func countDownStep() {
        soundManager.playFXSound(for: .countDownBip)
    }
    
    public func countDownEnded() {
        state = .playing
        soundManager.playFXSound(for: .countDownEnd)
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


