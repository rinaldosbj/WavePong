//
//  GameScene.swift
//  WavePong
//
//  Created by Lucas Migge on 28/07/23.
//

import Foundation
import SpriteKit
import UIKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var soundManager = SoundManager.shared
    
    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    var scoreLabel: SKLabelNode!
    var score = 0
    let newBall = Ball()
    var paddle: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        soundManager.playGameTheme()
        
        self.physicsWorld.contactDelegate = self
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsWorld.speed = 1
        
        let borderNode = SKNode()
        borderNode.physicsBody = border
        
        addChild(borderNode)
        
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        newBall.position = CGPoint(x:self.frame.midX,
                                   y:  self.frame.midY)
        
        newBall.run(SKAction.applyImpulse(CGVector(dx: 15, dy: 15), duration: 1))
        
        
        scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.text = "Score: 0"
        scoreLabel.fontSize = 20
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - 30)
        addChild(scoreLabel)
        
        paddle = SKSpriteNode(color: SKColor.white, size: CGSize(width: 100, height: 20))
        paddle.position = CGPoint(x: size.width / 2, y: 50)
        paddle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 20))
        paddle.physicsBody?.affectedByGravity = false
        paddle.physicsBody?.isDynamic = false // A paleta não deve se mover
        paddle.physicsBody?.restitution = 1.5
        
        
        newBall.name = "ballNode"
        newBall.physicsBody?.categoryBitMask = 1 // BitMask para a bola
        newBall.physicsBody?.contactTestBitMask = 2 // BitMask para colisões com a raquete
        addChild(newBall)
        
        paddle.name = "paddleNode"
        paddle.physicsBody?.categoryBitMask = 2 // BitMask para a raquete
        paddle.physicsBody?.restitution = 1
        addChild(paddle)
    }
    
    // MARK: Touches
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        paddle.position.x = location.x
    }
    
    // MARK: Colisions
    func didBegin(_ contact: SKPhysicsContact) {
        let ballCategory: UInt32 = 1 // BitMask da bola
        let paddleCategory: UInt32 = 2 // BitMask da raquete
        
        if (contact.bodyA.categoryBitMask & ballCategory) == ballCategory {
            // Colisão entre a bola e a raquete
            if (contact.bodyB.categoryBitMask & paddleCategory) == paddleCategory {
                // Bola colidiu com a raquete
                score += 1
                scoreLabel.text = "Score: \(score)"
                
                impactFeedbackGenerator.impactOccurred()
            }
        } else if (contact.bodyB.categoryBitMask & ballCategory) == ballCategory {
            // Colisão entre a bola e a raquete
            if (contact.bodyA.categoryBitMask & paddleCategory) == paddleCategory {
                // Bola colidiu com a raquete
                score += 1
                scoreLabel.text = "Score: \(score)"
                
                impactFeedbackGenerator.impactOccurred()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let position = newBall.position
        let size = frame.size
        soundManager.updateAudioOrientation(ballPosition: position, frameSize: size)
    }
    
}


