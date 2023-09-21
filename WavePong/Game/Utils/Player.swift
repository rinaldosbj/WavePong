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
    
    var theme: Theme {
        let intResult = defaults.integer(forKey: Constants.chosenGameTheme)
        
        switch intResult {
        case 1:
            return ThemeFactory().createTheme(theme: .variation1)
        default:
            return ThemeFactory().createTheme(theme: .defaultTheme)
        }
    }
    
    func setTheme(for theme: ThemeStyle) {
        defaults.set(theme.rawValue, forKey: Constants.chosenGameTheme)
    }
    
    
    
    init(defaults: UserDefaultable = UserDefaults.standard) {
        self.defaults = defaults
    }

    private struct Constants {
        static var userTopScoreEasy = "userTopScoreEasy"
        static var userTopScoreMedium = "userTopScoreMedium"
        static var userTopScpreHard = "userTopScorehard"
        static var soundMod = "soundMod"
        static var chosenBall = "chosenBall"
        static var chosenGameTheme = "chosenGameTheme"
    }

    
    private let defaults: UserDefaultable
    
    
    var selectedBall: PreviousBallSkin {
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
    
    func changeBall(_ ball: PreviousBallSkin) {
        defaults.set(ball.rawValue, forKey: Constants.chosenBall)
    }
    
    
    func userTopScore(forDificulty dificulty: GameDifficulty) -> Int {
        switch dificulty {
        case .easy:
            return defaults.integer(forKey: Constants.userTopScoreEasy)
        case .medium:
            return defaults.integer(forKey: Constants.userTopScoreMedium)
        case .hard:
            return defaults.integer(forKey: Constants.userTopScpreHard)
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
                defaults.set(score, forKey: Constants.userTopScpreHard)
                
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
protocol PlayerProtocol:PlayerScorePersistence,
                        PlayerPreferencesPersistence {
    
}


protocol PlayerScorePersistence {
    /// must return the highest score for a given dificulty
    func userTopScore(forDificulty dificulty: GameDifficulty) -> Int
    
    /// Must be called for persisting the highest score of user for
    func updateTopScore(NewTopScore score: Int, forDificulty dificulty: GameDifficulty)
}


protocol PlayerPreferencesPersistence {

    var selectedBall: PreviousBallSkin { get }
    
    func changeBall(_ ball: PreviousBallSkin)
    
    var soundMode: SoundMode { get }
    
    var theme: Theme { get }
    
    func setTheme(for theme: ThemeStyle)
    
    func changeSoundMode(_ mode: SoundMode)
    
}
