//
//  OnboardingGameScene.swift
//  WavePong
//
//  Created by Lucas Migge on 29/09/23.
//

import Foundation
import SpriteKit
import SwiftUI


class OnboardingGameScene: SKScene {
    
    var updateSceneStrategy: OnboardingGameSceneStrategy

    var soundManager: SoundManagerProtocol? = SoundManager.shared
    
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
        
        let sceneInfo = AudioOrientationInfo(paddlePosition: paddle.position, ballPosition: ball.position, size: size)
        
        updateSceneStrategy.executeStrategy(sceneInfo: sceneInfo) { newPosition in
            self.ball.position = newPosition
        }
        
        let info = AudioOrientationInfo(paddlePosition: paddle.position, ballPosition: ball.position, size: size)
        soundManager?.updateAudioOrientation(info)
    }
    
    
    init(size: CGSize, strategy: OnboardingGameSceneStrategy) {
        self.updateSceneStrategy = strategy
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
    
    func changeStrategy() {
        print(updateSceneStrategy)
        //        self.updateSceneStrategy = VolumeOnboardingStrategy()
        
        //        print(updateSceneStrategy)
    }
    
    
}