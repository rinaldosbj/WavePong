//
//  Ball.swift
//  WavePong
//
//  Created by Lucas Migge on 28/07/23.
//

import Foundation
import SpriteKit


// class of game Ball
class Ball: SKShapeNode {
    init(radius: CGFloat, color: UIColor) {
        super.init()
        
        // MARK: construct
        let path = CGMutablePath()
        path.addArc(center: .zero, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        self.path = path
        self.fillColor = color
        self.name = "ballNode"
        self.zPosition = 1
        
        // MARK: physicsBody
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius )
        self.physicsBody?.friction = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = 1 // BitMask para a bola
        self.physicsBody?.contactTestBitMask = 2 | 4 | 8 // BitMask para colisões com a raquete
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BallSprite: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "ball"
        self.zPosition = 1
        
        // MARK: physicsBody
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2 - size.width/3.8)
        self.physicsBody?.mass = 20
        self.physicsBody?.friction = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = 1 // BitMask para a bola
        self.physicsBody?.contactTestBitMask = 2 | 4 | 8 // BitMask para colisões com a raquete
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
