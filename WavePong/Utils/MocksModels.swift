//
//  MocksModels.swift
//  WavePong
//
//  Created by Lucas Migge on 29/08/23.
//

import Foundation
import UIKit

class PlayerMock: PlayerProtocol {
    
    var onboradingHappend: Bool = false
    
    var soundMode: Pong.SoundMode = .linear
    
    var userTopScoreEasy = 0
    var userTopScoreMedium = 0
    var userTopScoreHard = 0
    
    
    func userTopScore(forDificulty dificulty: GameDifficulty) -> Int {
        switch dificulty {
        case .easy:
            return userTopScoreEasy
        case .medium:
            return userTopScoreMedium
        case .hard:
            return userTopScoreHard
        }
    }
    
    func updateTopScore(NewTopScore score: Int, forDificulty dificulty: GameDifficulty) {
        switch dificulty {
        case .easy:
            userTopScoreEasy = score
        case .medium:
            userTopScoreMedium = score
        case .hard:
            userTopScoreHard = score
        }
        
    }
    
    
    func userFinishedOnboarding() {
//        onboradingHappend = true
    }
    
    
    func changeSoundMode(_ mode: Pong.SoundMode) {
//        soundMode = mode
        
    }
    
}

class UserDefaultsMock: UserDefaultable {

    
    
    var didSeeOnboarding: Bool = false
    var userTopScoreEasy = 0
    var userTopScoreMedium = 0
    var userTopScoreHard = 0
    
    var soundMod: Int = 0
    
    private struct Constants {
        static var hasSeenOnboarding = "hasSeenOnboarding"
        static var userTopScoreEasy = "userTopScoreEasy"
        static var userTopScoreMedium = "userTopScoreMedium"
        static var userTopScpreHard = "userTopScorehard"
        static var soundMod = "soundMod"
    }
    
    
    func bool(forKey: String) -> Bool {
        if forKey == Constants.hasSeenOnboarding {
            return didSeeOnboarding
        } else {
            return false
        }
    }
    
    func integer(forKey: String) -> Int {
        switch forKey {
        case Constants.soundMod:
            return soundMod
        case Constants.userTopScoreEasy:
            return userTopScoreEasy
        case Constants.userTopScoreMedium:
            return userTopScoreMedium
        case Constants.userTopScpreHard:
            return userTopScoreHard
        case Constants.soundMod:
            return soundMod
            
        default:
            return 0
        }
        
    }
    
    
    func set(_ value: Bool, forKey defaultName: String) {
        if defaultName == Constants.hasSeenOnboarding {
            didSeeOnboarding = value
        }
    }
    
    func set(_ value: Int, forKey defaultName: String) {
        switch defaultName {
        case Constants.soundMod:
            soundMod = value
        case Constants.userTopScoreEasy:
            userTopScoreEasy = value
        case Constants.userTopScoreMedium:
            userTopScoreMedium = value
        case Constants.userTopScpreHard:
            userTopScoreHard = value
        case Constants.soundMod:
            soundMod = value

        default:
            return
   
        }
        
    }
        
    
    
}

class SoundManagerMock: SoundManagerProtocol {
    
    var isPlayingGameTheme: Bool = false
    var isGameThemePaused: Bool = false
    var wasGamethemeResumed: Bool = false
    var didPlayedFXSound: Bool = false
    var lastFXSoundPlayed: FXSounds?
    
    
    static var shared: SoundManagerProtocol = SoundManagerMock()
    
    var player: PlayerProtocol
    
    init(player: PlayerProtocol = PlayerMock()) {
        self.player = player
    }
    
    func updateAudioOrientation(ballPosition position: CGPoint, frameSize size: CGSize) {
        
    }
    
    func playGameTheme() {
        isPlayingGameTheme = true
        
    }
    
    func pauseGameTheme() {
        isPlayingGameTheme = false
        isGameThemePaused = true
        
    }
    
    func resumeGameTheme() {
        isGameThemePaused = false
        isPlayingGameTheme = true
        
    }
    
    func stopGameTheme() {
        isGameThemePaused = false
        isPlayingGameTheme = false
        
    }
    
    func playFXSound(for name: FXSounds) {
        didPlayedFXSound = true
        lastFXSoundPlayed = name
        
    }
    
    
}


class HapticsManagerMock: HapticsManagerProtocol {
    
    static var shared: HapticsManagerProtocol = HapticsManagerMock()
    
    var didVibrate: Bool = false
    var lastNotificationFeedbackType: UINotificationFeedbackGenerator.FeedbackType?
    var lastImpactFeedbackType: UIImpactFeedbackGenerator.FeedbackStyle?
    
    
    func vibrate() {
        didVibrate = true
    }
    
    func vibrateNotification(for type: UINotificationFeedbackGenerator.FeedbackType) {
        didVibrate = true
        lastNotificationFeedbackType = type
    }
    
    func vibrateImpact(for type: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat) {
        didVibrate = true
        lastImpactFeedbackType = type
        
    }
    
    
}


class GameSceneMock: GameSceneDelegate {
    var isGameRunning: Bool = true

    
    func UserScored(newScore score: Int) {
        
    }
    
    func gameOver() {
        isGameRunning = false
        
    }
    
    func pausePressed() {
        isGameRunning = false
        
    }
    
    func resumeGame() {
        isGameRunning = true
        
    }
    
    func startGame() {
        isGameRunning = true
        
    }
    
    func resetGame() {
        
    }
    
    
}

class GameManagerDelegateMock: GameManagerDelegate {
    
    var state: GameSceneViewState = .game
    
    func pauseNodePressed() {
        state = .pause
        
    }
    
    func gameOver(scoreLabel: String, recordLabel: String) {
        state = .gameOver
        
    }
    
    
}


class GameManagerMock: GameManagerProtocol {
    
    var didPauseNodePressed: Bool = false
    
    var soundManager: SoundManagerProtocol = SoundManagerMock()
    
    var hapticsManager: HapticsManagerProtocol = HapticsManagerMock()
    
    var gameDificulty: GameDifficulty = .easy
    
    var score: Int = 0
    
    var gameManagerSetting: gameManagerSettings = gameManagerSettings(difficulty: .easy)
    
    var state: GameManager.GameManagerState = .InContDown
    
    var physicsDetection: PhysicsDetection = PhysicsDetection()

    var sceneDelegate: GameSceneDelegate?
    
    var gameManagerDelegate: GameManagerDelegate?
    
    var player: PlayerProtocol = PlayerMock()
    
    func startGame() {
        
    }
    
    func incrementBallSpeed() {
        
    }
    
    func correctedBallSpeed(for velocity: CGFloat) -> CGFloat {
        return 0
    }
    
    func resumeGame() {
        
    }
    
    func resetGame() {
        
    }
    
    func pauseNodePressed() {
        didPauseNodePressed = true
        
    }
    
    func pauseTrigger() {
        
    }
    
    func updateAudioOrientation(ballPosition: CGPoint, frameSize: CGSize) {
        
    }
    
    func countDownStep() {
        
    }
    
    func countDownEnded() {
        
    }
    
    func incrementScore() {
        
    }
    
    func didLose() {
        
    }

    
    
}
