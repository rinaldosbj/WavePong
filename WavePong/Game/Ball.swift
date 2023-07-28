//
//  Ball.swift
//  WavePong
//
//  Created by Lucas Migge on 28/07/23.
//

import Foundation
import SpriteKit


/// class of game Ball
class Ball: SKShapeNode {
    init(radius: CGFloat = 20, color: UIColor = .cyan) {
        super.init()

        let path = CGMutablePath()
        path.addArc(center: .zero, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)

        self.path = path
        self.fillColor = color
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius )
        self.physicsBody?.mass = 1
        self.physicsBody?.friction = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
