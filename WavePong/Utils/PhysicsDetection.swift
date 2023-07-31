//
//  PhysicsDetection.swift
//  WavePong
//
//  Created by LoreVilaca on 31/07/23.
//

import SpriteKit
import GameplayKit

struct ColliderType{
    static let BALL: UInt32 = 0x1 << 0
    static let PADDLE: UInt32 = 0x1 << 1
}

class PhysicsDetection: NSObject, SKPhysicsContactDelegate{
    
    var isCollidingWithPaddle = false
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderType.BALL | ColliderType.PADDLE{
            isCollidingWithPaddle = true
            print("colidiu")
        }
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == ColliderType.BALL | ColliderType.PADDLE{
            isCollidingWithPaddle = false
        }

    }
    
}
