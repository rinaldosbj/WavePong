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


class GameScene: SKScene {
    
    var soundManager = SoundManager.shared
    var gameManager: GameManager
    var ball: BallSprite!
    var paddle: Paddle!
    var cloud: Cloud!
    var cloud2: Cloud!
    var cloud3: Cloud!
    var scoreLabel: ScoreLabel!
    var borderNode: Border!
    var pauseNode: PauseNode!
    var countDown: SKSpriteNode!
    var countDownBackground : SKSpriteNode!
    
    
    var ballSpeed: CGFloat = 500
    let balSpeedMax: CGFloat = 1500
    
    var canPause = false
    
    var background = SKSpriteNode(imageNamed: "backgroundGame")
    
    public init(size: CGSize, gameManager: GameManager) {
        
        self.gameManager = gameManager
        
        super.init(size: size)
        self.ball = createBall()
        self.paddle = createPaddle()
        self.cloud = createCloud()
        self.cloud2 = creatCloud2()
        self.cloud3 = createCloud3()
        self.scoreLabel = createScoreLabel()
        self.pauseNode = createPauseNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        if isInGame() {
            setupGameManager()
            setupWorld()
            setupComponentsPosition()
            createCountDown()
        }
    }
    
    override func willMove(from view: SKView) {
        print("entrou no willMove")
        if isInGame() {
            gameManager.didExit()
        }
    }
    
    func startGame() {
        ball.run(SKAction.applyImpulse(createRandomVector(), duration: 1))
        moveClouds()

    }
    
    override func update(_ currentTime: TimeInterval) {
        soundManager.updateAudioOrientation(ballPosition: ball.position, frameSize: frame.size)
        
        updateBallSpeed()
    }
    
    func moveClouds() {
        moveCloudsVertical()
        moveCloudsHorizontal()
    }
    
    func moveCloudsVertical() {
        cloud.run(SKAction.moveTo(y: self.frame.midY + 90, duration: 18))
        cloud2.run(SKAction.moveTo(y: self.frame.midY + 95, duration: 19))
        cloud3.run(SKAction.moveTo(y: self.frame.midY + 100, duration: 20))

    }
    
    func moveCloudsHorizontal() {
        moveCloudNodeHorizontal()
        moveCloudNode2Horizontal()
        moveCloudNode3Horizontal()
    }
      
    func moveCloudNodeHorizontal() {
        let moveLeft = SKAction.moveTo(x: self.frame.midX + 25, duration: 0.75)
        let moveRight = SKAction.moveTo(x: self.frame.midX - 25, duration: 0.75)
        
        let sequence = SKAction.sequence([moveLeft, moveRight])
        let repeatForever = SKAction.repeatForever(sequence)
        
        cloud.run(repeatForever)

    }
    
    func moveCloudNode2Horizontal() {
        let moveLeft = SKAction.moveTo(x: self.frame.midX + 15, duration: 1.33)
        let moveRight = SKAction.moveTo(x: self.frame.midX - 15, duration: 1.33)
        
        let sequence = SKAction.sequence([moveRight, moveLeft])
        let repeatForever = SKAction.repeatForever(sequence)
        
        cloud2.run(repeatForever)

    }
    
    func moveCloudNode3Horizontal() {
        let moveLeft = SKAction.moveTo(x: self.frame.midX + 17, duration: 1)
        let moveRight = SKAction.moveTo(x: self.frame.midX - 17, duration: 1)
        
        let sequence = SKAction.sequence([moveLeft, moveRight])
        let repeatForever = SKAction.repeatForever(sequence)
        
        cloud3.run(repeatForever)
        
    }
    
    private func updateBallSpeed(increment: CGFloat = 0.5) {
        if ballSpeed < balSpeedMax {
            ballSpeed += increment
        }
        
        // corrects vertical speed
        if (ball.physicsBody?.velocity.dy)! < 0 && (ball.physicsBody?.velocity.dy)! > -ballSpeed {
            ball.physicsBody?.velocity.dy = -ballSpeed
        }
        if (ball.physicsBody?.velocity.dy)! > 0 && (ball.physicsBody?.velocity.dy)! < ballSpeed {
            ball.physicsBody?.velocity.dy = ballSpeed
        }
        
        // corrects horizontal speed
        if (ball.physicsBody?.velocity.dx)! < 0 && (ball.physicsBody?.velocity.dx)! > -ballSpeed {
            ball.physicsBody?.velocity.dx = -ballSpeed
        }
        if (ball.physicsBody?.velocity.dx)! > 0 && (ball.physicsBody?.velocity.dx)! < ballSpeed {
            ball.physicsBody?.velocity.dx = ballSpeed
        }
        
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
    func resumeGame() {
        self.isPaused = false
        soundManager.resumeGameTheme()
    }
    
    func UserScored(newScore score: Int) {
        scoreLabel.text = "\(score)"
        backgroundColor = gameManager.colors[Int.random(in: 0..<3)]
        
    }
    
    func gameOver() {
        self.isPaused = true
    }
    
    func pausePressed() {
        self.scene?.isPaused = true
        
    }
    
    func isInGame() -> Bool {
        if GameSceneViewModel.shared.state == .game {
            return true
        }
        else {
            return false
        }
    }
    
}


