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
    var ball: Ball!
    var paddle: Paddle!
    var cloud: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var borderNode: Border!
    let pauseNode = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
    
    
    var ballSpeed: CGFloat = 500
    let balSpeedMax: CGFloat = 1500
    
    public init(size: CGSize, gameManager: GameManager) {

        self.gameManager = gameManager
        
        super.init(size: size)
        self.ball = createBall()
        self.paddle = createPaddle()
        self.cloud = createCloud()
        self.scoreLabel = createScoreLabel()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        setupGameManager()
        setupWorld()
        setupComponents()
        startGame()
        
        pauseNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(pauseNode)
        
    }
    
    func viewWillDisappear() {
        isPaused = true
        soundManager.stopGameTheme()
    }
    
    func startGame() {
        ball.run(SKAction.applyImpulse(createRandomVector(), duration: 1))
        cloud.run(SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.midY + 100), duration: 20))
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        soundManager.updateAudioOrientation(ballPosition: ball.position, frameSize: frame.size)
        
        updateBallSpeed()
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
    func UserScored(newScore score: Int) {
        scoreLabel.text = "\(score)"
        backgroundColor = gameManager.colors[Int.random(in: 0..<3)]
        
    }
    
    func gameOver() {
        isPaused = true
    }
    
    func pausePressed() {
        isPaused = true
        
    }
    
}


