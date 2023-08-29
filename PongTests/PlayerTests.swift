//
//  PlayerTests.swift
//  WavePong
//
//  Created by Lucas Migge on 29/08/23.
//

import XCTest
@testable import Pong

final class PlayerTests: XCTestCase {
    
    var player: PlayerProtocol!
    var userDefaultsMock: UserDefaultsMock!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userDefaultsMock = UserDefaultsMock()
        player = Player(defaults: userDefaultsMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    
    func testShouldshowOnboardingOnFirstLaunch() {
        XCTAssertFalse(player.onboradingHappend)
    }
    
    func testShouldNotShowOnboardingAfterFirstLaunch() {
        player.userFinishedOnboarding()
        
        player = Player(defaults: userDefaultsMock)
        
        XCTAssertTrue(player.onboradingHappend)
        
    }
    
    func testUpdateTopScore() {
        let newTopScore = 10
        
        player.updateTopScore(NewTopScore: newTopScore)
        
        player = Player(defaults: userDefaultsMock)
        
        XCTAssertEqual(newTopScore, player.userTopScore)
    }
    
    func testShouldNotUpdateScopeIfIsntHigher() {
        let highstScore = 50
        userDefaultsMock.topScpre = highstScore
        
        player.updateTopScore(NewTopScore: 10)
        
        player = Player(defaults: userDefaultsMock)
        
        XCTAssertEqual(highstScore, player.userTopScore)
        
    }
    
    func testChangeSoundMode() {
        userDefaultsMock.soundMod = SoundMode.linear.rawValue
        
        let newSoundMode = SoundMode.curved
        
        player.changeSoundMode(newSoundMode)
        
        player = Player(defaults: userDefaultsMock)
        
        XCTAssertEqual(newSoundMode.rawValue, player.soundMode.rawValue)
        
        
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
