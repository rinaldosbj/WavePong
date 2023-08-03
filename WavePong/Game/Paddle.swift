//
//  Paddle.swift
//  WavePong
//
//  Created by rsbj on 31/07/23.
//

import SpriteKit

class Paddle: SKSpriteNode{
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        // MARK: construct
        super.init(texture: texture, color: color, size: size)
        self.name = "paddleNode"
        self.zPosition = 1
        
        // MARK: physicsBody
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.restitution = 1.5
        self.physicsBody?.categoryBitMask = 2 // BitMask para a raquete
        self.physicsBody?.restitution = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
