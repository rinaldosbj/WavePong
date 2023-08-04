//
//  GameScene+setupWorld.swift
//  WavePong
//
//  Created by rsbj on 31/07/23.
//

import SpriteKit

extension GameScene {
    func setupWorld(){
        // MARK: Border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        let borderNode = SKNode()
        borderNode.physicsBody = border
        borderNode.zPosition = 1
        addChild(borderNode)
        
        // MARK: World
        self.physicsWorld.speed = 0.5
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    func setupComponents(){
        // MARK: Paddle
        paddle = Paddle(texture: nil,
                        color: .purple,
                        size: CGSize(width: 100, height: 20))
        paddle.position = CGPoint(x: self.frame.midX,
                                  y: 50)
        addChild(paddle)
        
        // MARK: Ball
        ball = Ball(radius: 20,
                       color: .yellow)
        ball.position = CGPoint(x:self.frame.midX,
                                y:self.frame.midY)
        addChild(ball)
        
        // MARK: Cloud
        cloud = SKSpriteNode(color: .systemPink,
                             size: self.size)
        cloud.zPosition = 2
        cloud.position = CGPoint(x: self.frame.midX,
                                 y: self.frame.maxY + cloud.size.height/2)
        addChild(cloud)
        
        
    }
}
