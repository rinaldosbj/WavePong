//
//  Border.swift
//  WavePong
//
//  Created by rsbj on 11/08/23.
//

import Foundation
import SpriteKit


// class of game Ball
class Border: SKNode {
    var border = SKPhysicsBody()
    
    init(reactFrame: CGRect) {
        super.init()
        border = SKPhysicsBody(edgeLoopFrom: reactFrame)
    
        border.friction = 0
        border.restitution = 1
        border.categoryBitMask = 8
        self.physicsBody = border
        self.zPosition = 1

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
