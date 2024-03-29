//
//  GameManagerTests.swift
//  PongTests
//
//  Created by Lucas Migge on 29/08/23.
//

@testable import Pong
import XCTest
import SpriteKit

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
            gameDifficulty: .easy,
            soundManager: soundManagerMock,
            hapticsManager: hapticsManagerMock,
            player: playerMock
        )
        
        gameManager.sceneDelegate = gameSceneDelegateMock
        gameManager.gameManagerDelegate = gameManagerDelegateMock
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testCallsFeedbackWhenContDownStepCalled() {
        gameManager.countDownStep()
        
        XCTAssertTrue(soundManagerMock.didPlayedFXSound)
        XCTAssertEqual(FXSounds.countDownBip, soundManagerMock.lastFXSoundPlayed)
    }
    
    func testCallsFeebackwhenContDownEndedCalled() {
        gameManager.countDownEnded()
        
        XCTAssertTrue(soundManagerMock.didPlayedFXSound)
        XCTAssertEqual(FXSounds.countDownEnd, soundManagerMock.lastFXSoundPlayed)
        
    }
    
    func testStartGameChangeManagerState() {
        gameManager.state = .InContDown
        
        gameManager.startGame()
        
        let expectedManagerState = GameManager.GameManagerState.playing
        
        XCTAssertEqual(expectedManagerState, gameManager.state)
        
    }
    
    func testIfPadlleContactIncreasesScore() {
        gameManager.score = 0
        
        gameManager.physicsDetection.gameColisionDelegate?.incrementScore()
        
        let expectedScore = 1
        
        XCTAssertEqual(expectedScore, gameManager.score)
        
    }
    
    func testIfPaddleContactCallsFeedback() {
        // given
        soundManagerMock.lastFXSoundPlayed = nil
        hapticsManagerMock.didVibrate = false
        
        // when
        gameManager.physicsDetection.gameColisionDelegate?.incrementScore()
        
        // then
        
        let expectedFXSound = FXSounds.shooting
        
        XCTAssertEqual(expectedFXSound, soundManagerMock.lastFXSoundPlayed)
        XCTAssertTrue(hapticsManagerMock.didVibrate)
        
        
    }
    
    
    func testContactGameOver() {
        soundManagerMock.lastFXSoundPlayed = nil
        hapticsManagerMock.didVibrate = false
        
        gameManager.physicsDetection.gameColisionDelegate?.didLose()
        
        let expectedFXSound = FXSounds.explosion
        
        XCTAssertTrue(hapticsManagerMock.didVibrate)
        XCTAssertEqual(expectedFXSound, soundManagerMock.lastFXSoundPlayed)
        
        
    }
    
    func testDidLoseNewRecord() {
        let userTopScore = 1
        soundManagerMock.lastFXSoundPlayed = nil
        hapticsManagerMock.didVibrate = false
        playerMock.updateTopScore(NewTopScore: userTopScore, forDificulty: gameManager.gameDifficulty)
        
        
        let newScore = 60
        gameManager.score = newScore
        gameManager.didLose()
        
        let expectedFXSound = FXSounds.winzinho
        
        XCTAssertTrue(hapticsManagerMock.didVibrate)
        XCTAssertEqual(expectedFXSound, soundManagerMock.lastFXSoundPlayed)
        XCTAssertEqual(newScore, playerMock.userTopScore(forDificulty: gameManager.gameDifficulty))
    }
    
    func testDidLoseGameOver() {
        let userTopScore = 100
        soundManagerMock.lastFXSoundPlayed = nil
        hapticsManagerMock.didVibrate = false
        playerMock.updateTopScore(NewTopScore: userTopScore, forDificulty: gameManager.gameDifficulty)
        
        
        
        gameManager.score = 15
        gameManager.didLose()
        
        
        let expectedFXSound = FXSounds.explosion
        
        XCTAssertTrue(hapticsManagerMock.didVibrate)
        XCTAssertEqual(expectedFXSound, soundManagerMock.lastFXSoundPlayed)
        XCTAssertEqual(userTopScore, playerMock.userTopScore(forDificulty: gameManager.gameDifficulty))
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
        XCTAssertEqual(gameManagerDelegateMock.state, .pause)
        
    }
    
    func testResumeGame() {
        soundManagerMock.isPlayingGameTheme = false
        gameSceneDelegateMock.isGameRunning = false
        
        gameManager.resumeGame()
        
        XCTAssertTrue(soundManagerMock.isPlayingGameTheme)
        XCTAssertTrue(gameSceneDelegateMock.isGameRunning)
        
        
    }
    
    func testResetGame() {
        gameManager.score = 10
        gameManager.state = .playing
        soundManagerMock.isPlayingGameTheme = true
        
        gameManager.resetGame()
        
        XCTAssertEqual(gameManager.score, 0)
        XCTAssertEqual(gameManager.state, .InContDown)
        XCTAssertFalse(soundManagerMock.isPlayingGameTheme)
        
    }
    
    func testUpdateGameSceneChangeBallVelocity() {
        let frameSize = CGSize(width: 100, height: 100)
        let ballPosition = CGPoint(x: 50, y: 50)
        let ballVelocity = CGVector(dx: 1, dy: 1)
        
        let ball = SKNode()
        ball.position = ballPosition
        ball.physicsBody?.velocity = ballVelocity
        
        let paddle = SKNode()
        
        
        let updatableNodes = UpdatableSceneNodes(paddle: ball, ball: paddle, size: frameSize)
        
        
        
        gameManager.updateGameScene(nodes: updatableNodes) { newVelocity in
            XCTAssertNotEqual(ballVelocity, newVelocity)
        }
        

        
    }
    
    func testUpdateGameSceneCallsUpdateAudioOrientation() {
        
        
        let updatableNodes = UpdatableSceneNodes(paddle: SKNode(),
                                                 ball: SKNode(),
                                                 size: CGSize()
        )
        
        
        gameManager.updateGameScene(nodes: updatableNodes) { newVelocity in
        
        }
        
        XCTAssertTrue(self.soundManagerMock.updateAudioOrientationCalled)
    }
    
    func testWallCollisionIsChangingHorizontalBallSpeed() {
        let oldVelocity = gameManager.gameManagerSetting.ballSpeed
        
        gameManager.wallColision()
        
        let newVelocity = gameManager.gameManagerSetting.ballSpeed
        
        XCTAssertNotEqual(oldVelocity, newVelocity)
    }
}
