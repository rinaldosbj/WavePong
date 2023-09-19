//
//  Player.swift
//  WavePong
//
//  Created by Lucas Migge on 08/08/23.
//

import Foundation


/// Class responsable for persisting and updating user info about the app
class Player: PlayerProtocol {

    static var shared: Player = Player()
    
    init(defaults: UserDefaultable = UserDefaults.standard) {
        self.defaults = defaults
    }
    
    
    
    private struct Constants {
        static var hasSeenOnboarding = "hasSeenOnboarding"
        static var userTopScoreEasy = "userTopScoreEasy"
        static var userTopScoreMedium = "userTopScoreMedium"
        static var userTopScoreHard = "userTopScorehard"
        static var soundMod = "soundMod"
        static var chosenBall = "chosenBall"
    }
    
    private let defaults: UserDefaultable
    
    ///  Informs if the user already seen onboarding
    var onboradingHappend: Bool {
        return defaults.bool(forKey: Constants.hasSeenOnboarding)
    }
    
    var selectedBall: BallTypes {
        let intResult = defaults.integer(forKey: Constants.chosenBall)
        
        switch intResult {
        case 0:
            return .ball_yellow
        case 1:
            return .ball_green
        case 2:
            return .ball_cyan
        case 3:
            return .ball_blue
        case 4:
            return .ball_purple
        case 5:
            return .ball_red
        case 6:
            return .ball_orange
        default:
            return .ball_yellow
        }
        
    }
    
    func changeBall(_ ball: BallTypes) {
        defaults.set(ball.rawValue, forKey: Constants.chosenBall)
    }
    
    /// Once player finishes onboarding, this methods must be called so the app won't show onboading every launch
    func userFinishedOnboarding() {
        defaults.set(true, forKey: Constants.hasSeenOnboarding)
    }
    
    func userTopScore(forDificulty dificulty: GameDifficulty) -> Int {
        switch dificulty {
        case .easy:
            return defaults.integer(forKey: Constants.userTopScoreEasy)
        case .medium:
            return defaults.integer(forKey: Constants.userTopScoreMedium)
        case .hard:
            return defaults.integer(forKey: Constants.userTopScoreHard)
        }
    }
    
    
    /// Must be called if score of game was higher than the previous top score. Updates
    func updateTopScore(NewTopScore score: Int, forDificulty dificulty: GameDifficulty) {
        if score > userTopScore(forDificulty: dificulty) {
            switch dificulty {
            case .easy:
                defaults.set(score, forKey: Constants.userTopScoreEasy)
            case .medium:
                defaults.set(score, forKey: Constants.userTopScoreMedium)
            case .hard:
                defaults.set(score, forKey: Constants.userTopScoreHard)
                
            }
  
        }
    }
    
    var soundMode: SoundMode {
        let intResult = defaults.integer(forKey: Constants.soundMod)
        
        switch intResult {
        case 0:
            return .linear
        case 1:
            return .curved
        case 2:
            return .highContrast
        default:
            return .linear
        }
        
        
    }
    
    func changeSoundMode(_ mode: SoundMode) {
        defaults.set(mode.rawValue, forKey: Constants.soundMod)
        
    }
}

/// Defines a standard interface for Player Class
protocol PlayerProtocol {
    
    /// Should return true if the user didn't seen onboarding yet
    var onboradingHappend: Bool { get }
    
    
    /// Must be used for updating the info that user has seen onboarding and shouldn't show it anymore on launch
    func userFinishedOnboarding()
    
    func userTopScore(forDificulty dificulty: GameDifficulty) -> Int
    
    /// Must be called for persisting the highest score of user
    func updateTopScore(NewTopScore score: Int, forDificulty dificulty: GameDifficulty)
    
    var selectedBall: BallTypes { get }
    
    func changeBall(_ ball: BallTypes)
    
    var soundMode: SoundMode { get }
    
    func changeSoundMode(_ mode: SoundMode)
}
