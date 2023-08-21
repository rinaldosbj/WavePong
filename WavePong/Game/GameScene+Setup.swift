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
        let proportionalWidth: Double = Double(frame.width / 3)
        
        return Paddle(texture: nil,
                      color: .purple,
                      size: CGSize(width: proportionalWidth, height: 20))
        
    }
    
    func createBall() -> Ball {
        return Ball(radius: 20,
                    color: .yellow)
    }
    
    func createCloud() -> Cloud {
        let sizeWithIncremente: CGSize = CGSize(width: self.size.width + 50,
                                                height: self.size.height)
        
        return  Cloud(texture: SKTexture(imageNamed: "wave3"),
                             color: .systemPink,
                             size: sizeWithIncremente)
    }
    
    func creatCloud2() -> Cloud {
        let sizeWithIncremente: CGSize = CGSize(width: self.size.width + 50,
                                                height: self.size.height)
        
        return  Cloud(texture: SKTexture(imageNamed: "wave2"),
                             color: .systemPink,
                             size: sizeWithIncremente)
        
    }
    
    func createCloud3() -> Cloud {
        let sizeWithIncremente: CGSize = CGSize(width: self.size.width + 50,
                                                height: self.size.height)
        
        return  Cloud(texture: SKTexture(imageNamed: "wave"),
                             color: .systemPink,
                             size: sizeWithIncremente)
        
    }
    
    func createScoreLabel() -> ScoreLabel {
        return ScoreLabel()
    }
    
    func createPauseNode() -> PauseNode {
        let pauseNode = PauseNode(texture: SKTexture(imageNamed: "pause"),
                                  color: .cyan,
                                  size: CGSize(width: 42, height: 42))
        
        return pauseNode
    }
    
    func setupComponentsPosition(){
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
        
        cloud2.zPosition = 3
        cloud2.position = CGPoint(x: self.frame.midX,
                                 y: self.frame.maxY + cloud.size.height/2)
        addChild(cloud2)
        
        cloud3.zPosition = 3
        cloud3.position = CGPoint(x: self.frame.midX,
                                 y: self.frame.maxY + cloud.size.height/2)
        addChild(cloud3)
        
        
        scoreLabel.zPosition = 4
        scoreLabel.position = CGPoint(x: 50,
                                      y: self.frame.maxY - 75)
        addChild(scoreLabel)
        
        
        pauseNode.position = CGPoint(x: self.frame.maxX - 50,
                                     y: self.frame.maxY - 50)
        pauseNode.zPosition = 5
        addChild(pauseNode)
        
        
        
        
        
    }
}
