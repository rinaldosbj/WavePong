//
//  GameScene.swift
//  WavePong
//
//  Created by Lucas Migge on 28/07/23.
//

import Foundation
import SpriteKit
import UIKit


class GameScene: SKScene {
    
    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)

    var soundManager = SoundManager.shared
    var gameManager = GameManager()
    var ball: Ball!
    var paddle: Paddle!
    var cloud: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        gameManager.sceneDelegate = self
        self.physicsWorld.contactDelegate = gameManager.physicsDetection
        setupWorld()
        setupComponents()
        startGame()
    }
    
    func startGame(){
        ball.run(SKAction.applyImpulse(CGVector(dx: 15, dy: 15), duration: 1))
        cloud.run(SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.midY + 100), duration: 20))
    }
    
<<<<<<< HEAD
=======
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
>>>>>>> develop
    
}

extension GameScene: GameSceneProtocol {
    func didUserScored(newScore score: Int) {
        backgroundColor = gameManager.colors[Int.random(in: 0..<3)]
        print("Novo score: \(score)")
    }
    
}

protocol GameSceneProtocol {
    func didUserScored(newScore score: Int)
    
    
}
