//
//  GameScene.swift
//  WavePong
//
//  Created by Lucas Migge on 28/07/23.
//

import Foundation
import SpriteKit


class GameScene: SKScene {

    override func didMove(to view: SKView) {

        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1

        self.physicsWorld.speed = 1
        let borderNode = SKNode()
        borderNode.physicsBody = border

        addChild(borderNode)
        

        let newBall = Ball()
        newBall.position = CGPoint(x:self.frame.midX,
                                   y:  self.frame.midY)

        newBall.run(SKAction.applyImpulse(CGVector(dx: 100, dy: 100), duration: 10))


        addChild(newBall)


    }


}



