//
//  Player.swift
//  WavePong
//
//  Created by Lucas Migge on 08/08/23.
//

import Foundation

/// Class responsable for persisting and updating user info about the app
class Player: PlayerProtocol {
    
    init(defaults: UserDefaultable = UserDefaults.standard) {
        self.defaults = defaults
    }
    
    private struct Constants {
        static var hasSeenOnboarding = "hasSeenOnboarding"
        static var userTopScore = "userTopScore"
    }
    
    private let defaults: UserDefaultable
    
    ///  Informs if the user already seen onboarding
    var shouldShowOnborading: Bool {
        return defaults.bool(forKey: Constants.hasSeenOnboarding)
    }
    
    ///  Informs the highest score achieved by the player
    var userTopScore: Int {
        return defaults.integer(forKey: Constants.userTopScore)
    }
    
    /// Once player finishes onboarding, this methods must be called so the app won't show onboading every launch
    func userFinishedOnboarding() {
        defaults.set(true, forKey: Constants.hasSeenOnboarding)
    }
    
    /// Must be called if score of game was higher than the previous top score. Updates
    func updateTopScore(NewTopScore score: Int) {
        defaults.set(score, forKey: Constants.userTopScore)
    }

}

extension UserDefaults: UserDefaultable { }


protocol UserDefaultable {
    func bool(forKey: String) -> Bool
    
    func integer(forKey: String) -> Int
    
    func set(_ value: Bool, forKey defaultName: String)
    
    func set(_ value: Int, forKey defaultName: String)
    
}

/// Defines a standard interface for Player Class
protocol PlayerProtocol {
    
    /// Should return true if the user didn't seen onboarding yet
    var shouldShowOnborading: Bool { get }
    
    /// Should return the highest Score achives by user
    var userTopScore: Int { get }
    
    /// Must be used for updating the info that user has seen onboarding and shouldn't show it anymore on launch
    func userFinishedOnboarding()
    
    /// Must be called for persisting the highest score of user
    func updateTopScore(NewTopScore score: Int)
    
}
