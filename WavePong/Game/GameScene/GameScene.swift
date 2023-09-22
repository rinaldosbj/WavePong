//
//  GameScene.swift
//  WavePong
//
//  Created by Lucas Migge on 28/07/23.
//

import Foundation
import SpriteKit
import UIKit
import SwiftUI


class GameScene: SKScene, AudioNodesRelatable {
    
    var gameManager: GameManager
    var ball: BallSprite?
    var paddle: Paddle?
    var cloud: Cloud?
    var cloud2: Cloud?
    var cloud3: Cloud?
    var scoreLabel: ScoreLabel?
    var borderNode: Border?
    var pauseNode: PauseNode?
    var countDownNode: SKSpriteNode?
    var countDownBackground : SKSpriteNode?
    
    var background = SKSpriteNode(imageNamed: "backgroundGame")
    
    public init(size: CGSize, gameManager: GameManager) {
        
        self.gameManager = gameManager
        super.init(size: size)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        if isInGame() {
            setupGameScene()
            countDownAnimation()
        }
    }
    
    func setupGameScene() {
        setupGameManager()
        setupWorld()
        setupNodes()
        setupComponentsPosition()
        
    }
    
    func startGame() {
        ball?.run(SKAction.applyImpulse(createRandomVector(), duration: 1))
        animateClouds()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        gameManager.updateGameScene(nodes: self) { newVelocity in
            self.ball?.physicsBody?.velocity.dy = newVelocity.dy
            self.ball?.physicsBody?.velocity.dx = newVelocity.dx
        }

    }
    
    func animateClouds() {
        cloudsVerticalAnimation()
        cloudsHorizontalAnimation()
    }
    
    private func cloudsVerticalAnimation() {
        // TODO: Subitrair 100 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        // MARK: ISSO TA CAUSANDO LAG NA GAMESCENE
        cloud?.run(SKAction.moveTo(y: self.frame.midY + 200, duration: gameManager.gameManagerSetting.cloudVelocity))
        cloud2?.run(SKAction.moveTo(y: self.frame.midY + 215, duration: gameManager.gameManagerSetting.cloudVelocity))
        cloud3?.run(SKAction.moveTo(y: self.frame.midY + 230, duration: gameManager.gameManagerSetting.cloudVelocity))
        
    }
    
    private func cloudsHorizontalAnimation() {
        moveCloudNodeHorizontal()
        moveCloudNode2Horizontal()
        moveCloudNode3Horizontal()
    }
    
    private func moveCloudNodeHorizontal() {
        let moveLeft = SKAction.moveTo(x: self.frame.midX + 25, duration: 0.75)
        let moveRight = SKAction.moveTo(x: self.frame.midX - 25, duration: 0.75)
        
        let sequence = SKAction.sequence([moveLeft, moveRight])
        let repeatForever = SKAction.repeatForever(sequence)
        
        cloud?.run(repeatForever)
        
    }
    
    private func moveCloudNode2Horizontal() {
        let moveLeft = SKAction.moveTo(x: self.frame.midX + 15, duration: 1.33)
        let moveRight = SKAction.moveTo(x: self.frame.midX - 15, duration: 1.33)
        
        let sequence = SKAction.sequence([moveRight, moveLeft])
        let repeatForever = SKAction.repeatForever(sequence)
        
        cloud2?.run(repeatForever)
        
    }
    
    private func moveCloudNode3Horizontal() {
        let moveLeft = SKAction.moveTo(x: self.frame.midX + 17, duration: 1)
        let moveRight = SKAction.moveTo(x: self.frame.midX - 17, duration: 1)
        
        let sequence = SKAction.sequence([moveLeft, moveRight])
        let repeatForever = SKAction.repeatForever(sequence)
        
        cloud3?.run(repeatForever)
        
    }
    
    private func createRandomVector() -> CGVector {
        let startAtRightOrientation = Bool.random()
        let randomX = Double.random(in: 4...10)
        
        var vectorX: Double = 0
        
        if startAtRightOrientation {
            vectorX = randomX
        } else {
            vectorX = randomX * -1
        }
        
        return CGVector(dx: vectorX, dy: 15)
    }
    
}

extension GameScene: GameSceneDelegate {
    func resetGame() {
        
        self.isPaused = false
        
        resetSpriteNodes()
        
        setupGameManager()
        setupWorld()
        setupComponentsPosition()
        countDownAnimation()
        
    }
    
    func resumeGame() {
        isPaused = false
    }
    
    func userScored(newScore score: Int) {
        scoreLabel?.text = "\(score)"
        
    }
    
    func gameOver() {
        self.isPaused = true
        removeAllChildren()
    }
    
    func pausePressed() {
        self.scene?.isPaused = true
        
    }
    
    private func resetSpriteNodes() {
        removeAllChildren()
        setupNodes()
        
    }
    
    func isInGame() -> Bool {
        gameManager.state != .gameOver ? true : false
    }
    
}


