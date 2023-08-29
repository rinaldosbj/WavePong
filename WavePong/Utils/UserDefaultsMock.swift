//
//  UserDefaultsMock.swift
//  WavePong
//
//  Created by Lucas Migge on 29/08/23.
//

import Foundation

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
