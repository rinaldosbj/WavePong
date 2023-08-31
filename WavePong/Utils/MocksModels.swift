//
//  MocksModels.swift
//  WavePong
//
//  Created by Lucas Migge on 29/08/23.
//

import Foundation
import UIKit

class PlayerMock: PlayerProtocol {
    func userTopScore(forDificulty dificulty: GameDifficulty) -> Int {
        return 0
    }
    
    func updateTopScore(NewTopScore score: Int, forDificulty dificulty: GameDifficulty) {
        
    }
    
    var onboradingHappend: Bool = false
    
    var topScore = 0
    
    var soundMode: Pong.SoundMode = .linear
    
    func userFinishedOnboarding() {
    }
    
    func updateTopScore(NewTopScore score: Int) {
        topScore = score
    }
    
    func changeSoundMode(_ mode: Pong.SoundMode) {
        
    }
    
}

class UserDefaultsMock: UserDefaultable {
    
    var didSeeOnboarding: Bool = false
    var topScpre: Int = 0
    var soundMod: Int = 0
    
    private struct Constants {
        static var hasSeenOnboarding = "hasSeenOnboarding"
        static var userTopScore = "userTopScore"
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
        if forKey == Constants.userTopScore {
            return self.topScpre
        } else if forKey == Constants.soundMod {
            return self.soundMod
        } else  {
            return 0
        }

    }
    
    func string(forKey defaultName: String) -> String? {
        return nil
        
    }
    
    func set(_ value: Bool, forKey defaultName: String) {
        if defaultName == Constants.hasSeenOnboarding {
            didSeeOnboarding = value
        }
    }
    
    func set(_ value: Int, forKey defaultName: String) {
        if defaultName == Constants.userTopScore {
            topScpre = value
        } else if defaultName == Constants.soundMod {
            soundMod = value
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
