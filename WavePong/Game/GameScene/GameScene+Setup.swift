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
        addChild(borderNode ?? SKNode())
        
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
    
    func countDownAnimation() {
        
        let animationFadeInSlow = SKAction.fadeIn(withDuration: 0.6)
        let animationFadeInFast = SKAction.fadeIn(withDuration: 0.1)
        let animationFadeOutSlow = SKAction.fadeOut(withDuration: 0.6)
        let animationFadeOut = SKAction.fadeOut(withDuration: 0.2)
        let animationFadeOutFast = SKAction.fadeOut(withDuration: 0.05)
        
        let animation1 = SKAction.animate(with: [SKTexture(imageNamed: "count1")], timePerFrame: 0)
        let animation2 = SKAction.animate(with: [SKTexture(imageNamed: "count2")], timePerFrame: 1)
        let animation3 = SKAction.animate(with: [SKTexture(imageNamed: "count3")], timePerFrame: 1)
        let animation4 = SKAction.animate(with: [SKTexture(imageNamed: "count4")], timePerFrame: 1)
        
        let bipSound = SKAction.run {
            self.gameManager.countDownStep()
        }
        let endSound = SKAction.run {
            self.gameManager.countDownEnded()
        }
        
        let performStartGame = SKAction.run { [weak self] in
            if self?.isInGame() == true {
                self?.countDownBackground?.isHidden = true
                self?.countDownNode?.isHidden = true
                self?.gameManager.startGame()
            }
        }
        
        let changeSize1 = SKAction.run { [weak self] in
            self?.countDownNode?.size = CGSize(width: 44, height: 87)
        }
        
        let changeSize3 = SKAction.run { [weak self] in
            self?.countDownNode?.size = CGSize(width: 54, height: 87)
        }
        
        let changeSizeGoLabel = SKAction.run { [weak self] in
            self?.countDownNode?.size = CGSize(width: 160, height: 87)
        }
        
        let wait = SKAction.wait(forDuration: 0.4)
        let wait1sec = SKAction.wait(forDuration: 0.9)
        
        let countDownSequence = SKAction.sequence([animationFadeOutFast,
                                                wait,
                                                animationFadeInSlow, animationFadeOut,
                                                wait,
                                                animationFadeInFast, animationFadeOut,
                                                animationFadeInFast, animationFadeOutFast,
                                                animationFadeInFast, animationFadeOutFast,
                                                animationFadeInFast, animationFadeOutSlow,
                                                   
                                                changeSize3,animation1,
                                                animationFadeInFast, wait1sec, bipSound,
                                                animation2, bipSound, changeSize1,
                                                animation3,changeSizeGoLabel,endSound,
                                                animation4,performStartGame
                                               ])
        
        countDownNode?.run(countDownSequence)
        
    }
    
    func setupComponentsPosition(){
        paddle?.position = CGPoint(x: self.frame.midX,
                                  y: 125)
        addChild(paddle ?? SKNode())
        
        ball?.position = CGPoint(x:self.frame.midX,
                                y: 175)
        addChild(ball ?? SKNode())
      
        
        cloud?.zPosition = 2
        cloud?.position = CGPoint(x: self.frame.midX,
                                 y: self.frame.maxY + cloud!.size.height/2)
        addChild(cloud ?? SKNode())
        
        cloud2?.zPosition = 3
        cloud2?.position = CGPoint(x: self.frame.midX,
                                  y: self.frame.maxY + cloud!.size.height/2 + 15)
        addChild(cloud2 ?? SKNode())
        
        cloud3?.zPosition = 3
        cloud3?.position = CGPoint(x: self.frame.midX,
                                  y: self.frame.maxY + cloud!.size.height/2 + 30)
        addChild(cloud3 ?? SKNode())
        
        
        scoreLabel?.zPosition = 4
        scoreLabel?.position = CGPoint(x: 50,
                                      y: self.frame.maxY - 100)
        addChild(scoreLabel ?? SKNode())
        
        
        pauseNode?.position = CGPoint(x: self.frame.maxX - 50,
                                     y: self.frame.maxY - 75)
        pauseNode?.zPosition = 5
        addChild(pauseNode ?? SKNode())
        
        countDownBackground?.position = CGPoint(x: frame.midX, y: frame.midY)
        countDownBackground?.zPosition = 1000
        addChild(countDownBackground ?? SKNode())
        
        countDownNode?.position = CGPoint(x: frame.midX, y: frame.midY)
        countDownNode?.zPosition = 1000
        addChild(countDownNode ?? SKNode())

        
    }
    
    // MARK: Create Nodes
    func createCountDownBackground() -> SKSpriteNode {
        let coundDownBackground = SKSpriteNode(color: .black, size: self.size)
        coundDownBackground.alpha = 0.7

        return coundDownBackground
    }
    
    func createCountDownLabel() -> SKSpriteNode {
        let countDownNode = SKSpriteNode(texture: SKTexture(imageNamed: "fone"))

        return countDownNode
    }
    
    func createPaddle() -> Paddle {
        let proportionalWidth = Double(frame.width * gameManager.gameManagerSetting.paddleProportion)
        
        return Paddle(texture: nil,
                      color: UIColor(named: "Light-purple")!,
                      size: CGSize(width: proportionalWidth, height: 20))
        
    }
    
    func createBall() -> BallSprite {
        return BallSprite(texture: SKTexture(image: UIImage(named: "neonBall")!), color: .clear, size: gameManager.gameManagerSetting.ballSize)
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
    
    
}
