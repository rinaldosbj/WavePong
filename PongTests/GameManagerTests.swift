//
//  GameManagerTests.swift
//  PongTests
//
//  Created by Lucas Migge on 29/08/23.
//

@testable import Pong
import XCTest

final class GameManagerTests: XCTestCase {
    
    var playerMock: PlayerMock!
    var soundManagerMock: SoundManagerMock!
    var hapticsManagerMock: HapticsManagerMock!
    var gameSceneDelegateMock: GameSceneMock!
    var gameManagerDelegateMock: GameManagerDelegateMock!
    var gameManager: GameManagerProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        playerMock = PlayerMock()
        soundManagerMock = SoundManagerMock(player: playerMock)
        hapticsManagerMock = HapticsManagerMock()
        gameSceneDelegateMock = GameSceneMock()
        gameManagerDelegateMock = GameManagerDelegateMock()
        
        gameManager = GameManager(
            soundManager: soundManagerMock,
            hapticsManager: hapticsManagerMock,
            player: playerMock,
            gameDifficulty: .easy
        )
        
        gameManager.sceneDelegate = gameSceneDelegateMock
        gameManager.gameManagerDelegate = gameManagerDelegateMock
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testCallsFeedbackWhenContDownStepOver() {
        gameManager.countDownStep()
        
        XCTAssertTrue(soundManagerMock.didPlayedFXSound)
        XCTAssertEqual(FXSounds.countDownBip, soundManagerMock.lastFXSoundPlayed)
    }
    
    func testStartGameChangeManagerState() {
        gameManager.state = .InContDown

        gameManager.startGame()
        
        let expectedManagerState = GameManager.GameManagerState.playing

        XCTAssertEqual(expectedManagerState, gameManager.state)

    }
    
    func testIfPadlleContactIncreasesScore() {
        gameManager.score = 0
        
        gameManager.physicsDetection.gameActionDelegate?.incrementScore()
        
        let expectedScore = 1
        
        XCTAssertEqual(expectedScore, gameManager.score)
        
    }
    
    func testIfPaddleContactCallsFeedback() {
        // given
        soundManagerMock.lastFXSoundPlayed = nil
        hapticsManagerMock.didVibrate = false
        
        // when
        gameManager.physicsDetection.gameActionDelegate?.incrementScore()
        
        // then
        
        let expectedFXSound = FXSounds.shooting
        
        XCTAssertEqual(expectedFXSound, soundManagerMock.lastFXSoundPlayed)
        XCTAssertTrue(hapticsManagerMock.didVibrate)
        
        
    }
    
    
    func testContactGameOver() {
        soundManagerMock.lastFXSoundPlayed = nil
        hapticsManagerMock.didVibrate = false
        
        gameManager.physicsDetection.gameActionDelegate?.didLose()
        
        let expectedFXSound = FXSounds.explosion
        
        XCTAssertTrue(hapticsManagerMock.didVibrate)
        XCTAssertEqual(expectedFXSound, soundManagerMock.lastFXSoundPlayed)
        
        
        
        
    }
    
    func testDidLoseNewRecord() {
        let userTopScore = 1
        soundManagerMock.lastFXSoundPlayed = nil
        hapticsManagerMock.didVibrate = false
        playerMock.updateTopScore(NewTopScore: userTopScore, forDificulty: gameManager.gameDificulty)
        
        
        let newScore = 60
        gameManager.score = newScore
        gameManager.didLose()
        
        let expectedFXSound = FXSounds.winzinho
        
        XCTAssertTrue(hapticsManagerMock.didVibrate)
        XCTAssertEqual(expectedFXSound, soundManagerMock.lastFXSoundPlayed)
        XCTAssertEqual(newScore, playerMock.userTopScore(forDificulty: gameManager.gameDificulty))
    }
    
    func testDidLoseGameOver() {
        let userTopScore = 100
        soundManagerMock.lastFXSoundPlayed = nil
        hapticsManagerMock.didVibrate = false
        playerMock.updateTopScore(NewTopScore: userTopScore, forDificulty: gameManager.gameDificulty)
        
        
        
        gameManager.score = 15
        gameManager.didLose()
        
        let expectedFXSound = FXSounds.explosion
        
        XCTAssertTrue(hapticsManagerMock.didVibrate)
        XCTAssertEqual(expectedFXSound, soundManagerMock.lastFXSoundPlayed)
        XCTAssertEqual(userTopScore, playerMock.userTopScore(forDificulty: gameManager.gameDificulty))
    }
    
    
    func testPauseTriggersWhenCountDown() {
        
        gameManager.pauseTrigger()
        
        XCTAssertFalse(soundManagerMock.isGameThemePaused)
        XCTAssertTrue(gameSceneDelegateMock.isGameRunning)
        
    }
    
    func testPauseTriggerWhenGameStarted() {
        gameManager.startGame()
        
        gameManager.pauseTrigger()
        
        XCTAssertTrue(soundManagerMock.isGameThemePaused)
        XCTAssertFalse(gameSceneDelegateMock.isGameRunning)
        
    }
    
    func testPauseNodePressedWhenCountDown() {
        gameManager.pauseNodePressed()
        
        XCTAssertFalse(soundManagerMock.isGameThemePaused)
        XCTAssertTrue(gameSceneDelegateMock.isGameRunning)
        
    }
    
    func testPauseNodePressedWhenGameStarted() {
        gameManager.startGame()
        
        gameManager.pauseNodePressed()
        
        XCTAssertTrue(soundManagerMock.isGameThemePaused)
        XCTAssertFalse(gameSceneDelegateMock.isGameRunning)
        XCTAssertEqual(gameManagerDelegateMock.state, .paused)
        
    }
}
