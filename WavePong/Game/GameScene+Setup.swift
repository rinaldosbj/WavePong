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
        
        background.size = size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        // MARK: inferiorWall
        let inferiorWall = SKSpriteNode(color: .clear, size: .init(width: self.frame.width, height: 1))
        inferiorWall.physicsBody = SKPhysicsBody(rectangleOf: .init(width: self.frame.width, height: 1))
        inferiorWall.physicsBody?.categoryBitMask = 4
        inferiorWall.physicsBody?.isDynamic = false
        inferiorWall.position = CGPoint(x: self.frame.midX, y: 5)
        
        
        addChild(inferiorWall)
        
        // MARK: World
        self.physicsWorld.speed = 0.5
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    func createCountDown() {
        let countTexture = [
            SKTexture(imageNamed: "count1"),
            SKTexture(imageNamed: "count2"),
            SKTexture(imageNamed: "count3")
        ]
        
        countDownBackground = SKSpriteNode(color: .black, size: self.size)
        countDownBackground.alpha = 0.7
        countDownBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        countDownBackground.zPosition = 1000
        addChild(countDownBackground)
        
        countDown = SKSpriteNode(texture: SKTexture(imageNamed: "count1"))
        countDown.size = CGSize(width: 54, height: 87)
        countDown.zPosition = 1000
        countDown.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(countDown)
        
        let animation1 = SKAction.animate(with: countTexture, timePerFrame: 1)
        let perform1 = SKAction.run { [weak self] in
           self?.countDown.size = CGSize(width: 160, height: 87)
        }
        let animation2 = SKAction.animate(with: [SKTexture(imageNamed: "count4")], timePerFrame: 1)
        let perform2 = SKAction.run { [weak self] in
            if self?.isInGame() == true {
                self?.countDownBackground.isHidden = true
                self?.countDown.isHidden = true
                self?.gameManager.startGame()
                self?.canPause = true
            }
        }
        
        let countDownSequence = SKAction.sequence([animation1,perform1,animation2,perform2])
        
        countDown.run(countDownSequence)
        
    }
    
    func createPaddle() -> Paddle {
        let proportionalWidth: Double = Double(frame.width / 3)
        
        return Paddle(texture: nil,
                      color: UIColor(named: "Light-purple")!,
                      size: CGSize(width: proportionalWidth, height: 20))
        
    }
    
    func createBall() -> BallSprite {
        return BallSprite(texture: SKTexture(image: UIImage(named: "neonBall")!), color: .clear, size: CGSize(width: 60, height: 60))
    }
    
    func createCloud() -> Cloud {
        let sizeWithIncremente: CGSize = CGSize(width: self.size.width + 50,
                                                height: self.size.height)
        
        return  Cloud(texture: SKTexture(imageNamed: "wave3"),
                      color: .systemPink,
                      size: sizeWithIncremente)
    }
    
    func creatCloud2() -> Cloud {
        let sizeWithIncremente: CGSize = CGSize(width: self.size.width + 65,
                                                height: self.size.height)
        
        return  Cloud(texture: SKTexture(imageNamed: "wave2"),
                      color: .systemPink,
                      size: sizeWithIncremente)
        
    }
    
    func createCloud3() -> Cloud {
        let sizeWithIncremente: CGSize = CGSize(width: self.size.width + 75,
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
                                      y: self.frame.maxY - 100)
        addChild(scoreLabel)
        
        
        pauseNode.position = CGPoint(x: self.frame.maxX - 50,
                                     y: self.frame.maxY - 75)
        pauseNode.zPosition = 5
        addChild(pauseNode)
        
        
        
        
        
    }
}
