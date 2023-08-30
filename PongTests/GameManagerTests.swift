//
//  GameManagerTests.swift
//  PongTests
//
//  Created by Lucas Migge on 29/08/23.
//

@testable import Pong
import XCTest

final class GameManagerTests: XCTestCase {
    
    var playerMock: Player!
    var soundManagerMock: SoundManagerMock!
    var hapticsManagerMock: HapticsManagerMock!
    var gameManager: GameManagerProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        playerMock = Player(defaults: UserDefaultsMock())
        soundManagerMock = SoundManagerMock(player: playerMock)
        hapticsManagerMock = HapticsManagerMock()
        
        gameManager = GameManager(
            soundManager: soundManagerMock,
            hapticsManager: hapticsManagerMock,
            player: playerMock)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testIfContDownStepCallsSound() {
        gameManager.countDownStep()
        
        XCTAssertTrue(soundManagerMock.didPlayedFXSound)
        XCTAssertEqual(FXSounds.countDownBip, soundManagerMock.lastFXSoundPlayed)
    }
    
    func testContDownEnded() {
        gameManager.state = .InContDown
        soundManagerMock.lastFXSoundPlayed = nil
        
        gameManager.countDownEnded()
        
        let expectedManagerState = GameManager.GameManagerState.playing
        let expectedSoundPlayed = FXSounds.countDownEnd
        
        XCTAssertEqual(expectedManagerState, gameManager.state)
        XCTAssertEqual(expectedSoundPlayed, soundManagerMock.lastFXSoundPlayed)
    }
    
    func testIfPadlleContactIncreasesScore() {
        gameManager.score = 0
        
        gameManager.incrementScore()
        
        let expectedScore = 1
        
        XCTAssertEqual(expectedScore, gameManager.score)
        
    }
    
    func testIfPaddleContactCallsFeedback() {
        // given
        soundManagerMock.lastFXSoundPlayed = nil
        hapticsManagerMock.didVibrate = false
        
        // when
        gameManager.incrementScore()
        
        // then
        
        let expectedFXSound = FXSounds.shooting
        
        XCTAssertEqual(expectedFXSound, soundManagerMock.lastFXSoundPlayed)
        XCTAssertTrue(hapticsManagerMock.didVibrate)
        
        
        
        
    }
    
}
