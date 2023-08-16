//
//  PauseNode.swift
//  WavePong
//
//  Created by Lucas Migge on 15/08/23.
//

import Foundation
import SpriteKit

class PauseNode: SKSpriteNode {
    
    override init(texture: SKTexture?,
                  color: UIColor,
                  size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.texture = texture
        self.color = color
        self.size = size
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
