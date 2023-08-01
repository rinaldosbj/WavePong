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
    
    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    var gameManager: GameManager?
    
    var ball: Ball!
    var paddle: Paddle!
    var cloud: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        setupWorld()
        setupComponents()
        
        gameManager = GameManager(scene: self)
        
        gameManager?.startPongGame(ball: ball, cloud: cloud!)
    }
    
    // MARK: Colisions
    func didBegin(_ contact: SKPhysicsContact) {
        let ballCategory: UInt32 = 1 // BitMask da bola
        let paddleCategory: UInt32 = 2 // BitMask da raquete
        
        if (contact.bodyA.categoryBitMask & ballCategory) == ballCategory {
            // Colisão entre a bola e a raquete
            if (contact.bodyB.categoryBitMask & paddleCategory) == paddleCategory {
                // Bola colidiu com a raquete
                impactFeedbackGenerator.impactOccurred()
            }
        } else if (contact.bodyB.categoryBitMask & ballCategory) == ballCategory {
            // Colisão entre a bola e a raquete
            if (contact.bodyA.categoryBitMask & paddleCategory) == paddleCategory {
                // Bola colidiu com a raquete
                gameManager!.incrementScore()
                impactFeedbackGenerator.impactOccurred()
            }
        }
    }
}

