//
//  Cloud.swift
//  WavePong
//
//  Created by Lucas Migge on 21/08/23.
//

import Foundation
import SpriteKit

class Cloud: SKSpriteNode {
    
    override init(texture: SKTexture?,
                  color: UIColor = .clear,
                  size: CGSize) {
        super.init(texture: texture,
                   color: color,
                   size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
