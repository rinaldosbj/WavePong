//
//  PhysicsDetection.swift
//  WavePong
//
//  Created by LoreVilaca on 31/07/23.
//

import SpriteKit

///  Responsable for managing colisions
class PhysicsDetection: NSObject, SKPhysicsContactDelegate {
    
    struct ColliderType{
        static let BALL: UInt32 = 1
        static let PADDLE: UInt32 = 2
        static let INFERIORBORDER: UInt32 = 4
        static let AROUNDBORDER: UInt32 = 8
    }

    var gameColisionDelegate: GameColisionDelegate?
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderType.BALL | ColliderType.PADDLE{
            gameColisionDelegate?.incrementScore()
        } else if collision == ColliderType.BALL | ColliderType.INFERIORBORDER {
            gameColisionDelegate?.didLose()
        }
        else if collision == ColliderType.BALL | ColliderType.AROUNDBORDER {
            gameColisionDelegate?.wallColision()
        }
    }
}
