//
//  GameSceneTests.swift
//  PongTests
//
//  Created by Lucas Migge on 05/09/23.
//

import Foundation
import XCTest
@testable import Pong


class GameSceneTests: XCTestCase {
    
    var gameManagerMock: GameManagerMock!
    var gameScene: GameScene!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameManagerMock = GameManagerMock()
        gameScene = GameScene(size: CGSize(), gameManager: gameManagerMock)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSceneHasBall() {
        gameScene.setupGameScene()
        
        XCTAssertNotNil(gameScene.ball)
    }
    
    func testSceneHasPaddle() {
        gameScene.setupGameScene()
        
        XCTAssertNotNil(gameScene.paddle)
        
    }
    
    func testSceneHasClouds() {
        gameScene.setupGameScene()
        
        XCTAssertNotNil(gameScene.cloud)
        XCTAssertNotNil(gameScene.cloud2)
        XCTAssertNotNil(gameScene.cloud3)
    }
    
    func testSceneHasScoreLabel() {
        gameScene.setupGameScene()
        
        XCTAssertNotNil(gameScene.scoreLabel)
    }
    
    func testSceneHasBorder() {
        gameScene.setupGameScene()
        
        XCTAssertNotNil(gameScene.borderNode)
    }
    
    func testSceneHasPauseNode() {
        gameScene.setupGameScene()
        
        XCTAssertNotNil(gameScene.pauseNode)
    }
    
    func testSceneHasCountDownNodes() {
        gameScene.setupGameScene()
        
        XCTAssertNotNil(gameScene.countDownNode)
        XCTAssertNotNil(gameScene.countDownBackground)
    }
    
    func testSetupGameManner() {
        gameScene.setupGameScene()

        XCTAssertNotNil(gameScene.gameManager.sceneDelegate)
        XCTAssertNotNil(gameScene.physicsWorld.contactDelegate)
    }
    
    func testSceneHasBackground() {
        gameScene.setupGameScene()
        
        XCTAssertNotNil(gameScene.background)
    }
    
}
