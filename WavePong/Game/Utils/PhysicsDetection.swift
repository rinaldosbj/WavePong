//
//  PhysicsDetection.swift
//  WavePong
//
//  Created by LoreVilaca on 31/07/23.
//

import SpriteKit



class PhysicsDetection: NSObject, SKPhysicsContactDelegate {
    
    struct ColliderType{
        static let BALL: UInt32 = 1
        static let PADDLE: UInt32 = 2
        static let INFERIORBORDER: UInt32 = 4
        static let AROUNDBORDER: UInt32 = 8
    }

    var gameActionDelegate: GameColisionDelegate?
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderType.BALL | ColliderType.PADDLE{
            gameActionDelegate?.incrementScore()
        } else if collision == ColliderType.BALL | ColliderType.INFERIORBORDER {
            gameActionDelegate?.didLose()
        }
        else if collision == ColliderType.BALL | ColliderType.AROUNDBORDER {
            print("Bateu na borda ao redor")
        }
        
        
    }
}
