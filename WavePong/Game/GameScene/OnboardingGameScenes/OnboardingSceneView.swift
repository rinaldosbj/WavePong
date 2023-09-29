//
//  OnboardingSceneView.swift
//  WavePong
//
//  Created by Lucas Migge on 25/09/23.
//

import SwiftUI
import SpriteKit



protocol OnboardingGameSceneStrategy {
    func executeStrategy(sceneInfo: AudioOrientationInfo, updatedBallPosition: @escaping (CGPoint) -> Void)
    
}

class PanOnboardingStrategy: OnboardingGameSceneStrategy {
    
    private var isBallGoingRight: Bool = true
    
    private var ballOrientation: Int {
        isBallGoingRight ? 1 : -1
    }
    
    func executeStrategy(sceneInfo: AudioOrientationInfo, updatedBallPosition: @escaping (CGPoint) -> Void) {
        
        let ballPosition = sceneInfo.ballPosition
        let width = sceneInfo.size.width
        
        
        if ballPosition.x > width - 5 {
            isBallGoingRight = false
        } else if ballPosition.x < 5 {
            isBallGoingRight = true
        }
        
        let newPosition = CGPoint(x: ballPosition.x + CGFloat(2 * ballOrientation),
                                  y: ballPosition.y)
        
        updatedBallPosition(newPosition)
        
    }
    
}

class VolumeOnboardingStrategy: OnboardingGameSceneStrategy {
    
    private var isBallGoingUp: Bool = true
    
    private var ballOrientation: Int {
        isBallGoingUp ? 1 : -1
    }
    
    func executeStrategy(sceneInfo: AudioOrientationInfo, updatedBallPosition: @escaping (CGPoint) -> Void) {
        
        let ballPosition = sceneInfo.ballPosition
        let minHeight = sceneInfo.paddlePosition.y + 30
        let height = sceneInfo.size.height - 50
        
        if ballPosition.y < minHeight {
            isBallGoingUp = true
        } else if ballPosition.y > height {
            isBallGoingUp = false
        }
        
        let newPosition = CGPoint(x: ballPosition.x,
                                  y: ballPosition.y + CGFloat(3 * ballOrientation))
        
        updatedBallPosition(newPosition)
        
    }
    
}

class PanAndVolumeOnboardingStrategy: OnboardingGameSceneStrategy {
    
    private var isBallGoingRight: Bool = true
    private var isBallGoingUp: Bool = true
    
    private var ballHorientationOrientation: Int {
        isBallGoingRight ? 1 : -1
    }
    
    private var ballVerticalHorientation: Int {
        isBallGoingUp ? 1 : -1
    }
    
    
    func executeStrategy(sceneInfo: AudioOrientationInfo, updatedBallPosition: @escaping (CGPoint) -> Void) {
        
        var ballPosition = sceneInfo.ballPosition
        let minHeight = sceneInfo.paddlePosition.y + 30
        let height = sceneInfo.size.height - 50
        let width = sceneInfo.size.width
        
        
        if ballPosition.y < minHeight {
            isBallGoingUp = true
        } else if ballPosition.y > height {
            isBallGoingUp = false
        }
        
        if ballPosition.x > width - 5 {
            isBallGoingRight = false
        } else if ballPosition.x < 5 {
            isBallGoingRight = true
        }
        
        ballPosition.x += CGFloat(2 * ballHorientationOrientation)
        ballPosition.y += CGFloat(3 * ballVerticalHorientation)
        
        updatedBallPosition(ballPosition)
        
    }
    
    
}


class OnboardingGameScene: SKScene {
    
    var updateSceneStrategy: OnboardingGameSceneStrategy = PanAndVolumeOnboardingStrategy()
    
    var soundManager: SoundManager? = nil
    
    var background = SKSpriteNode(imageNamed: "backgroundGame")
    
    var ball = BallSprite(texture: SKTexture(image: UIImage(named: "ball_yellow")!), color: .clear, size: CGSize(width: 80, height: 80))
    
    var paddle = Paddle(texture: nil,
                        color: UIColor(Color(ColorConstants.shared.PURPLE_300)),
                        size: CGSize(width: 150, height: 20))
    
    var panLabel: SKLabelNode = SKLabelNode(text: "Pan")
    var volumeLabel: SKLabelNode = SKLabelNode(text: "Volume")
    var gameLabel: SKLabelNode = SKLabelNode(text: "Both")
    
    
    
    
    override func didMove(to view: SKView) {
        background.size = size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        paddle.position = CGPoint(x: self.frame.midX,
                                  y: 125)
        addChild(paddle)
        
        ball.position = CGPoint(x:self.frame.midX,
                                y: 250)
        addChild(ball)
        
        
        panLabel.position = CGPoint(x: frame.midX,
                                    y: frame.height - 100)
        addChild(panLabel)
        
        volumeLabel.position = CGPoint(x: frame.midX,
                                       y: frame.height - 200)
        addChild(volumeLabel)
        
        gameLabel.position = CGPoint(x: frame.midX,
                                     y: frame.height - 300)
        addChild(gameLabel)
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        let sceneInfo = AudioOrientationInfo(paddlePosition: paddle.position, ballPosition: ball.position, size: size)
        
        updateSceneStrategy.executeStrategy(sceneInfo: sceneInfo) { newPosition in
            self.ball.position = newPosition
        }
        
        let info = AudioOrientationInfo(paddlePosition: paddle.position, ballPosition: ball.position, size: size)
        soundManager?.updateAudioOrientation(info)
    }
    
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if panLabel.contains(location) {
            updateSceneStrategy = PanOnboardingStrategy()
            return
        }
        
        if volumeLabel.contains(location) {
            updateSceneStrategy = VolumeOnboardingStrategy()
            return
        }
        
        if gameLabel.contains(location) {
            updateSceneStrategy = PanAndVolumeOnboardingStrategy()
            return
        }
        
        
        var horizontalLocation: Double {
            location.x
        }
        
        if isPaddlePositionTranspassingRight(horizontalLocation){
            paddle.position.x = frame.maxX - paddle.size.width/2
        }
        else if isPaddlePositionTranspassingLeft(horizontalLocation) {
            paddle.position.x = frame.minX + paddle.size.width/2
        }
        else {
            paddle.position.x = location.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        
        var horizontalLocation: Double {
            location.x
        }
        
        if isPaddlePositionTranspassingRight(horizontalLocation) {
            paddle.position.x = frame.maxX - paddle.size.width/2
        }
        else if isPaddlePositionTranspassingLeft(horizontalLocation){
            paddle.position.x = frame.minX + paddle.size.width/2
        }
        else {
            paddle.position.x = location.x
        }
    }
    
    private func isPaddlePositionTranspassingRight(_ location: Double) -> Bool {
        return location > frame.maxX - (paddle.size.width / 2)
    }
    
    private func isPaddlePositionTranspassingLeft(_ location: Double) -> Bool {
        return location < frame.minX + (paddle.size.width / 2)
    }
    
    func changeStrategy() {
        print(updateSceneStrategy)
        //        self.updateSceneStrategy = VolumeOnboardingStrategy()
        
        //        print(updateSceneStrategy)
    }
    
    
}

struct OnboardingSceneView: View {
    @Environment(\.dismiss) private var dismiss
    @State var size = CGSize()
    
    var soundManager: SoundManager?
    
    
    var scene: OnboardingGameScene {
        let scene = OnboardingGameScene(size: size)
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
                    .onAppear {
                        size = geo.size
                        soundManager?.playGameTheme()
                        
                    }
                VStack {
                    HStack {
                        Image("settings")
                            .onTapGesture {
                                soundManager?.stopGameTheme()
                                dismiss()
                            }
                            .padding()
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                
                
            }
            
        }
        
    }
}

#Preview {
    OnboardingSceneView()
}
