//
//  OnboardingGameSceneStrategy.swift
//  WavePong
//
//  Created by Lucas Migge on 29/09/23.
//

import Foundation


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
