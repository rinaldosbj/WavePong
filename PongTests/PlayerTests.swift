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
