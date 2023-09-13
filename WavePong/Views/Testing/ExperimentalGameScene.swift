//
//  ExperimentalGameScene.swift
//  WavePong
//
//  Created by Lucas Migge on 06/09/23.
//

import SwiftUI
import SpriteKit

class GameSceneExperimental: SKScene {
    var gameManager: ExperimentalGameManager
    var ball: BallSprite?
    var paddle: Paddle?
    var borderNode: Border?
    var background = SKSpriteNode(imageNamed: "backgroundGame")
    
    init(gameManager: ExperimentalGameManager, size: CGSize) {
        self.gameManager = gameManager
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        gameManager.sceneDelegate = self
        physicsWorld.contactDelegate = gameManager.physicsDetection
        setupComponents()
        startGame()

        
    }
    
    func startGame() {
        ball!.physicsBody?.velocity = createRandomVector()
    }
    
    func setupComponents() {
        
        // MARK: inferiorWall
        let inferiorWall = SKSpriteNode(color: .clear, size: .init(width: self.frame.width, height: 1))
        inferiorWall.physicsBody = SKPhysicsBody(rectangleOf: .init(width: self.frame.width, height: 1))
        inferiorWall.physicsBody?.categoryBitMask = 4
        inferiorWall.physicsBody?.isDynamic = false
        inferiorWall.position = CGPoint(x: self.frame.midX, y: 5)
        addChild(inferiorWall)
        
        
        borderNode = Border(reactFrame: self.frame)
        addChild(borderNode ?? SKNode())
        
        background.size = size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        ball = createBall()
        ball?.position = CGPoint(x:self.frame.midX,
                                 y: self.frame.maxY - 50)
        addChild(ball ?? SKNode())
        
        paddle = createPaddle()
        paddle?.position = CGPoint(x: self.frame.midX,
                                   y: 50)
        addChild(paddle ?? SKNode())
    }
    
    func createBall() -> BallSprite {
        return BallSprite(texture: SKTexture(image: UIImage(named: "neonBall")!), color: .clear, size: gameManager.gameManagerSetting.ballSize)
    }
    
    func createPaddle() -> Paddle {
        let proportionalWidth = Double(frame.width * gameManager.gameManagerSetting.paddleProportion)
        
        return Paddle(texture: nil,
                      color: UIColor(named: "Light-purple")!,
                      size: CGSize(width: proportionalWidth, height: 20))
        
    }
    
    func nextRound() {
        ball?.removeFromParent()
        
//        DispatchQueue.main.as
        
        ball = createBall()
        ball?.position = CGPoint(x:self.frame.midX,
                                 y: self.frame.maxY - 50)
        addChild(ball ?? SKNode())
        ball!.physicsBody?.velocity = createRandomVector()
        
    }
    
    private func createRandomVector() -> CGVector {
        let startAtRightOrientation = Bool.random()
        
        let randomX: Double = -100
        
        var vectorX: Double = 0
        
        if startAtRightOrientation {
            vectorX = randomX
        } else {
            vectorX = randomX * -1
        }
        
        return CGVector(dx: vectorX, dy: -50)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        guard let safePaddle = self.paddle else { return }
        
        
        var horizontalLocation: Double {
            location.x
        }
        
        if isPaddlePositionTranspassingRight(horizontalLocation){
            safePaddle.position.x = frame.maxX - safePaddle.size.width/2
        }
        else if isPaddlePositionTranspassingLeft(horizontalLocation) {
            safePaddle.position.x = frame.minX + safePaddle.size.width/2
        }
        else {
            safePaddle.position.x = location.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        guard let safePaddle = self.paddle else { return }
        
        var horizontalLocation: Double {
            location.x
        }
        
        if isPaddlePositionTranspassingRight(horizontalLocation) {
            safePaddle.position.x = frame.maxX - safePaddle.size.width/2
        }
        else if isPaddlePositionTranspassingLeft(horizontalLocation){
            safePaddle.position.x = frame.minX + safePaddle.size.width/2
        }
        else {
            safePaddle.position.x = location.x
        }
    }
    
    private func isPaddlePositionTranspassingRight(_ location: Double) -> Bool {
        guard let safePaddle = self.paddle else { return false }
        return location > frame.maxX - (safePaddle.size.width / 2)
    }
    
    private func isPaddlePositionTranspassingLeft(_ location: Double) -> Bool {
        guard let safePaddle = self.paddle else { return false }
        return location < frame.minX + (safePaddle.size.width / 2)
    }
}


extension GameSceneExperimental: GameSceneDelegate {
    
    func UserScored(newScore score: Int) {
        nextRound()
    }
    
    func gameOver() {
        
    }
    
    func pausePressed() {
        
    }
    
    func resumeGame() {
        
    }
    
    func resetGame() {
        
    }
    
    
}

class ExperimentalGameManager: GameColisionDelegate {
    var player: PlayerProtocol?
    
    var soundManager: SoundManagerProtocol?
    
    var hapticsManager: HapticsManagerProtocol?

    var sceneDelegate: GameSceneDelegate?
    
    var gameManagerDelegate: GameManagerDelegate?
    
    var gameDificulty: GameDifficulty = .easy
    
    var score: Int = 0
    
    var gameManagerSetting: gameManagerSettings = gameManagerSettings(difficulty: .easy)
    
    var state: GameManager.GameManagerState = .playing
    
    var physicsDetection: PhysicsDetection = PhysicsDetection()
    
    init() {
        self.physicsDetection.gameActionDelegate = self
    }
    
    func startGame() {
    
    }
    
    func incrementBallSpeed() {
        
    }
    
    func correctedBallSpeed(for velocity: CGFloat) -> CGFloat {
        return 0
    }
    
    func resumeGame() {
        return
    }
    
    func resetGame() {
        return
    }
    
    func pauseNodePressed() {
        return
    }
    
    func pauseTrigger() {
        return
    }
    
    func updateAudioOrientation(ballPosition: CGPoint, frameSize: CGSize) {
        return
    }
    
    func countDownStep() {
        return
    }
    
    func countDownEnded() {
        
    }
    
    func incrementScore() {
        sceneDelegate?.UserScored(newScore: score)
        
    }
    
    func didLose() {
        
    }
    

    
    
}



struct ExperimentalGameSceneView: View {
    
    var gameManager: ExperimentalGameManager {
        let manager = ExperimentalGameManager()
        manager.state = .playing
        return manager
    }
    
    @State var size: CGSize = CGSize()
    
    var gameScene: GameSceneExperimental {
        let gameScene = GameSceneExperimental(
            gameManager: gameManager,
            size: size)
        gameScene.scaleMode = .fill
        return gameScene
    }
    
    var body: some View {
        GeometryReader { geo in
            SpriteView(scene: gameScene)
            
                .ignoresSafeArea()
                .onAppear {
                    size = geo.size
                }
            
        }
        
    }
}

struct ExperimentalGameSceneView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentalGameSceneView()
    }
}
