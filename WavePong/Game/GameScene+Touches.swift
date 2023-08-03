//
//  Touches.swift
//  WavePong
//
//  Created by rsbj on 31/07/23.
//

import SpriteKit

extension GameScene{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        paddle.position.x = location.x
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        paddle.position.x = location.x
    }
}
