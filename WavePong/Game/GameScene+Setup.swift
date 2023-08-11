//
//  GameScene+setupWorld.swift
//  WavePong
//
//  Created by rsbj on 31/07/23.
//

import SpriteKit

extension GameScene {
    
    func setupGameManager() {
        gameManager.sceneDelegate = self
        self.physicsWorld.contactDelegate = gameManager.physicsDetection
    }
    
    func setupWorld(){
        // MARK: Border
        borderNode = Border(reactFrame: self.frame)
        addChild(borderNode)
        
        // MARK: inferiorWall
        let inferiorWall = SKSpriteNode(color: .green, size: .init(width: self.frame.width, height: 1))
        inferiorWall.physicsBody = SKPhysicsBody(rectangleOf: .init(width: self.frame.width, height: 1))
        inferiorWall.physicsBody?.categoryBitMask = 4
        inferiorWall.physicsBody?.isDynamic = false
        inferiorWall.position = CGPoint(x: self.frame.midX, y: 5)
        
        
        addChild(inferiorWall)
        
        // MARK: World
        self.physicsWorld.speed = 0.5
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    func createPaddle() -> Paddle {
        return Paddle(texture: nil,
                      color: .purple,
                      size: CGSize(width: 100, height: 20))
        
    }
    
    func createBall() -> Ball {
        return Ball(radius: 20,
                    color: .yellow)
    }
    
    func createCloud() -> SKSpriteNode {
       return  SKSpriteNode(color: .systemPink,
                             size: self.size)
    }
    
    func createScoreLabel() -> SKLabelNode {
        let label = SKLabelNode(text: "0")
        label.fontSize = 84
        return label
    }
    
    func setupComponents(){
        // MARK: Paddle
        paddle.position = CGPoint(x: self.frame.midX,
                                  y: 50)
        addChild(paddle)
        
        // MARK: Ball
        ball.position = CGPoint(x:self.frame.midX,
                                y:self.frame.midY)
        addChild(ball)
        
        // MARK: Cloud
        cloud.zPosition = 2
        cloud.position = CGPoint(x: self.frame.midX,
                                 y: self.frame.maxY + cloud.size.height/2)
        addChild(cloud)
        
        
        scoreLabel.zPosition = 3
        scoreLabel.position = CGPoint(x: frame.midX,
                                      y: frame.maxY - 150)
        
        addChild(scoreLabel)
        
        
        
        
        
    }
}
