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
        
        if pauseNode.contains(location) {
            gameManager.pauseNodePressed()
        }
        
        var horizontalLocation: Double {
            location.x
        }
        
        if isPaddlePositionTranspassingRight(horizontalLocation){
            paddle.position.x = frame.maxX - paddle.size.width/2
        }
        else if isPaddlePositionTranspassingLeft(horizontalLocation) {
            paddle.position.x = frame.minX + paddle.size.width/2
        }
        else {
            paddle.position.x = location.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        var horizontalLocation: Double {
            location.x
        }
        
        if isPaddlePositionTranspassingRight(horizontalLocation) {
            paddle.position.x = frame.maxX - paddle.size.width/2
        }
        else if isPaddlePositionTranspassingLeft(horizontalLocation){
            paddle.position.x = frame.minX + paddle.size.width/2
        }
        else {
            paddle.position.x = location.x
        }
    }
    
    private func isPaddlePositionTranspassingRight(_ location: Double) -> Bool {
        location > frame.maxX - (paddle.size.width / 2)
    }
    
    private func isPaddlePositionTranspassingLeft(_ location: Double) -> Bool {
        location < frame.minX + (paddle.size.width / 2)
    }
}
