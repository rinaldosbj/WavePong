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
        addChild(borderNode)
        
        // MARK: World
        self.physicsWorld.speed = 1
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
    }
}
