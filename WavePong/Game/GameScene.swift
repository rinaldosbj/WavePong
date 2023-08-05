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
    
    override func update(_ currentTime: TimeInterval) {
        soundManager.updateAudioOrientation(ballPosition: ball.position, frameSize: frame.size)
    }
        
}

extension GameScene: GameSceneProtocol {
    func didUserScored(newScore score: Int) {
        backgroundColor = gameManager.colors[Int.random(in: 0..<3)]
    }
    
    func gameOver() {
        self.isPaused = true
    }
    
}


