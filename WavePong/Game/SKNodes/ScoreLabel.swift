//
//  ScoreLabel.swift
//  WavePong
//
//  Created by Lucas Migge on 15/08/23.
//

import Foundation
import SpriteKit

class ScoreLabel: SKLabelNode {
    override init() {
        super.init()
        self.text = "0"
        self.fontSize = 60
        self.fontName = "strasua"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
