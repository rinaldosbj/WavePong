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
    
    func testUpdateTopScoreEasy() {
        // given
        let newTopScore = 10
        player.updateTopScore(NewTopScore: newTopScore, forDificulty: .easy)
        
        
        // when
        player = Player(defaults: userDefaultsMock)
        
        // then
        XCTAssertEqual(newTopScore, player.userTopScore(forDificulty: .easy))
    }
    
    func testShouldNotUpdateScopeIfIsntHigherEasy() {
        let highstScore = 50
        userDefaultsMock.userTopScoreEasy = highstScore
        
        player.updateTopScore(NewTopScore: 10, forDificulty: .easy)
        
        player = Player(defaults: userDefaultsMock)
        
        XCTAssertEqual(highstScore, player.userTopScore(forDificulty: .easy))
        
    }
    
    func testUpdateTopScoreMedium() {
        // given
        let newTopScore = 10
        player.updateTopScore(NewTopScore: newTopScore, forDificulty: .medium)
        
        
        // when
        player = Player(defaults: userDefaultsMock)
        
        // then
        XCTAssertEqual(newTopScore, player.userTopScore(forDificulty: .medium))
    }
    
    func testShouldNotUpdateScopeIfIsntHigherMedium() {
        let highstScore = 50
        userDefaultsMock.userTopScoreMedium = highstScore
        
        player.updateTopScore(NewTopScore: 10, forDificulty: .medium)
        
        player = Player(defaults: userDefaultsMock)
        
        XCTAssertEqual(highstScore, player.userTopScore(forDificulty: .medium))
        
    }
    
    func testUpdateTopScoreHard() {
        // given
        let newTopScore = 10
        player.updateTopScore(NewTopScore: newTopScore, forDificulty: .hard)
        
        
        // when
        player = Player(defaults: userDefaultsMock)
        
        // then
        XCTAssertEqual(newTopScore, player.userTopScore(forDificulty: .hard))
    }
    
    func testShouldNotUpdateScopeIfIsntHigherHard() {
        let highstScore = 50
        userDefaultsMock.userTopScoreHard = highstScore
        
        player.updateTopScore(NewTopScore: 10, forDificulty: .hard)
        
        player = Player(defaults: userDefaultsMock)
        
        XCTAssertEqual(highstScore, player.userTopScore(forDificulty: .hard
                                                       ))
        
    }
    
    func testChangeSoundMode() {
        userDefaultsMock.soundMod = SoundMode.linear.rawValue
        
        let newSoundMode = SoundMode.curved
        
        player.changeSoundMode(newSoundMode)
        
        player = Player(defaults: userDefaultsMock)
        
        XCTAssertEqual(newSoundMode.rawValue, player.soundMode.rawValue)
        
        
    }

    func testGetSoundModeHightConstrast() {
        let expectedSoundMode: SoundMode = SoundMode.highContrast
        
        userDefaultsMock.soundMod = expectedSoundMode.rawValue
        
        XCTAssertEqual(player.soundMode, expectedSoundMode)
        
    }


    func testGetSoundModeLinear() {
        let expectedSoundMode: SoundMode = SoundMode.linear
        
        userDefaultsMock.soundMod = expectedSoundMode.rawValue
        
        XCTAssertEqual(player.soundMode, expectedSoundMode)
        
    }
    
    func testGetSoundModeCurved() {
        let expectedSoundMode: SoundMode = SoundMode.curved
        
        userDefaultsMock.soundMod = expectedSoundMode.rawValue
        
        XCTAssertEqual(player.soundMode, expectedSoundMode)
        
    }
    
    func testChangeBall() {
        let previusBall: PreviousBallSkin = .ball_blue
        let newBall: PreviousBallSkin = .ball_red
        userDefaultsMock.ballType = previusBall.rawValue
        
        player.changeBall(newBall)
        
        XCTAssertNotEqual(previusBall, player.selectedBall)
        

    }
    
    
}
