//
//  OnboardingSceneView.swift
//  WavePong
//
//  Created by Lucas Migge on 25/09/23.
//

import SwiftUI
import SpriteKit



class OnboardingGameScene: SKScene {
    
    
    var isBallGoingRight: Bool = true
    
    var soundManager = SoundManager.shared
    
    var background = SKSpriteNode(imageNamed: "backgroundGame")
    
    var ball = BallSprite(texture: SKTexture(image: UIImage(named: "ball_yellow")!), color: .clear, size: CGSize(width: 80, height: 80))
    
    var paddle = Paddle(texture: nil,
                        color: UIColor(Color(ColorConstants.shared.PURPLE_300)),
                        size: CGSize(width: 150, height: 20))
    
    
    
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
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        let orientation = isBallGoingRight ? 1 : -1
        
        if ball.position.x > frame.width {
            isBallGoingRight = false
        } else if ball.position.x < 0 {
            isBallGoingRight = true
        }
        
        ball.position.x += CGFloat(3 * orientation)
        
        let info = AudioOrientationInfo(paddlePosition: paddle.position, ballPosition: ball.position, size: size)
        soundManager.updateAudioOrientation(info)
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
    
    
}

struct OnboardingSceneView: View {
    @Environment(\.dismiss) private var dismiss
    @State var size = CGSize()
    
    var soundManager = SoundManager.shared
    
    var scene: SKScene {
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
                        soundManager.playGameTheme()
                        
                    }
                VStack {
                    HStack {
                        Image("settings")
                            .onTapGesture {
                                soundManager.stopGameTheme()
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
