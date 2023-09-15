//
//  GameManager.swift
//  WavePong
//
//  Created by rsbj on 01/08/23.
//

import SpriteKit
import Firebase


/// Object responsable for dealing with game logic
class GameManager: GameManagerProtocol {
    
    let stringsConstants = StringsConstantsModel()
    
    enum GameManagerState {
        case InContDown, playing, gameOver
    }
    
    public var state: GameManagerState
    
    /// User Current Score
    public var score: Int
    
    public var gameDificulty: GameDifficulty {
        gameManagerSetting.difficulty
    }
    
    var gameManagerSetting: gameManagerSettings
    
    /// Instance for calling sounds
    internal var soundManager: SoundManagerProtocol
    /// Instance for calling vibrations
    internal var hapticsManager: HapticsManagerProtocol

    /// Instance for calling game center
    var gameCenterManager: GameCenterManager = GameCenterManager.shared
    
    /// Instance of object responsable for dealing with game colision logic
    internal var physicsDetection: PhysicsDetection
    
    /// Instance for interaction with the gameScene
    weak var sceneDelegate: GameSceneDelegate?
    /// Instantece for interaction with Game Scene View Model
    weak var gameManagerDelegate: GameManagerDelegate?
    
    /// Instance for acessing player preferences and topScore
    internal var player: PlayerProtocol
    
    internal var analyticsManager: AnalyticsManager
    
    
    
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
         player: PlayerProtocol = Player(),
         gameDifficulty: GameDifficulty,
         analyticsManager: AnalyticsManager = AnalyticsManager()
    ) {

        self.gameManagerSetting = gameManagerSettings(difficulty: gameDifficulty)
        self.score = score
        self.state = state
        self.soundManager = soundManager
        self.hapticsManager = hapticsManager
        self.physicsDetection = physicsDetection
        self.player = player
        self.analyticsManager = analyticsManager
        self.physicsDetection.gameActionDelegate = self
    }
    
    public func getCurrentBall() -> String {
        let currentBall = player.selectedBall
        
        switch currentBall {
        case .ball_yellow:
            return "ball_yellow"
        case .ball_green:
            return "ball_green"
        case .ball_cyan:
            return "ball_cyan"
        case .ball_blue:
            return "ball_blue"
        case .ball_purple:
            return "ball_purple"
        case .ball_red:
            return "ball_red"
        case .ball_orange:
            return "ball_orange"
            
        }
        
    }
    
    /// Informs Game Scene to start game and implements necesseray logic
    public func startGame() {
        analyticsManager.logGameSession(panStyle: player.soundMode,
                                        dificulty: self.gameDificulty)
        state = .playing
        sceneDelegate?.startGame()
        soundManager.playGameTheme()
        score = 0
    }
    
    func updateGameScene(frameSize: CGSize, ballPosition: CGPoint?, ballVelocity: CGVector?, ballVelocityCorrected: @escaping (CGVector) -> Void) {
        guard let position = ballPosition else { return }
        guard let velocity = ballVelocity else { return }
        
        
        updateAudioOrientation(ballPosition: position, frameSize: frameSize)
        incrementVecticalBallSpeed()
        ballVelocityCorrected(correctBallSpeed(for: velocity))
    }

    
    private func incrementVecticalBallSpeed() {
        let ballSpeed = gameManagerSetting.ballSpeed.dy
        let maxBallSpeed = gameManagerSetting.maxBallSpeed
        
        if ballSpeed < maxBallSpeed {
            gameManagerSetting.ballSpeed.dy += 2
        }
    }
    
    private func correctBallSpeed(for velocity: CGVector) -> CGVector {
        let ballSpeed = gameManagerSetting.ballSpeed
        
        var correctedVelocity = velocity
        
        if velocity.dy < 0 && velocity.dy > -ballSpeed.dy {
            correctedVelocity.dy = -ballSpeed.dy
        
        }
        if velocity.dy > 0 && velocity.dy < ballSpeed.dy {
            correctedVelocity.dy = ballSpeed.dy
        }
        
        if velocity.dx < 0 && velocity.dx > -ballSpeed.dx {
            correctedVelocity.dx = -ballSpeed.dx
        }
        if velocity.dx > 0 && velocity.dx < ballSpeed .dx{
            correctedVelocity.dx = ballSpeed.dx
        }
        
        return correctedVelocity
        
    }
    
    public func resumeGame() {
        soundManager.resumeGameTheme()
        sceneDelegate?.resumeGame()
    }
    
    public func resetGame() {
        analyticsManager.logGameSession(panStyle: player.soundMode,
                                        dificulty: self.gameDificulty)
        restoreGameManager()
        sceneDelegate?.resetGame()
    }
    
    public func restoreGameManager() {
        soundManager.stopGameTheme()
        state = .InContDown
        score = 0
    }
    
    public func pauseTrigger() {
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
        soundManager.playFXSound(for: .countDownEnd)
    }
    
}

extension GameManager: GameColisionDelegate {
    
    func wallColision() {
//        let randomIncrementHorizontalSpeed: CGFloat = CGFloat.random(in: -500...500)
//        let verticalSpeed: CGVector = gameManagerSetting.ballSpeed
//
//        gameManagerSetting.ballSpeed = CGVector(dx: verticalSpeed.dx + randomIncrementHorizontalSpeed,
//                                                dy: verticalSpeed.dy)
//        print("oioioi")
    }
    
    
    private var isNewRecord: Bool {
        score > player.userTopScore(forDificulty: self.gameDificulty)
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
        sceneDelegate?.userScored(newScore: score)
        
    }
    
    public func didLose() {
        soundManager.pauseGameTheme()
        state = .gameOver
        
        if isNewRecord {
            notifyUserOfEvent(.newTopScore)
            gameCenterManager.submitScore(with: score)
            player.updateTopScore(NewTopScore: score,
                                  forDificulty: self.gameDificulty)
            gameManagerDelegate?.gameOver(scoreLabel: "\(score)",
                                          recordLabel: stringsConstants.novo_record)
        } else {
            notifyUserOfEvent(.gameOver)
            var topScore: Int {
                Player.shared.userTopScore(forDificulty: self.gameDificulty)
            }
            gameManagerDelegate?.gameOver(scoreLabel: "\(score)",
                                          recordLabel: "\(stringsConstants.recorde) \(topScore)")
        }
        
        sceneDelegate?.gameOver()
        analyticsManager.logGameScore(score: score,
                                      dificulty: self.gameDificulty)
        
    }
    
    
    
}


