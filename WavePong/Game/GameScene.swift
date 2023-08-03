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
    var gameManager: GameManager?
    var ball: Ball!
    var paddle: Paddle!
    var cloud: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = physicsDelegate
        setupWorld()
        setupComponents()
        
        gameManager = GameManager(scene: self)
        gameManager?.startPongGame(ball: ball, cloud: cloud!)
    }
}

