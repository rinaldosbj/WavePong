//
//  Touches.swift
//  WavePong
//
//  Created by rsbj on 31/07/23.
//

import SpriteKit

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        guard let safePaddle = self.paddle else { return }
        guard let safePauseNode = self.pauseNode else { return }
        
        if safePauseNode.contains(location) {
            gameManager.pauseNodePressed()
        }
        
        var horizontalLocation: Double {
            location.x
        }
        
        if isPaddlePositionTranspassingRight(horizontalLocation){
            safePaddle.position.x = frame.maxX - safePaddle.size.width/2
        }
        else if isPaddlePositionTranspassingLeft(horizontalLocation) {
            safePaddle.position.x = frame.minX + safePaddle.size.width/2
        }
        else {
            safePaddle.position.x = location.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        guard let safePaddle = self.paddle else { return }
        
        var horizontalLocation: Double {
            location.x
        }
        
        if isPaddlePositionTranspassingRight(horizontalLocation) {
            safePaddle.position.x = frame.maxX - safePaddle.size.width/2
        }
        else if isPaddlePositionTranspassingLeft(horizontalLocation){
            safePaddle.position.x = frame.minX + safePaddle.size.width/2
        }
        else {
            safePaddle.position.x = location.x
        }
    }
    
    private func isPaddlePositionTranspassingRight(_ location: Double) -> Bool {
        guard let safePaddle = self.paddle else { return false }
        return location > frame.maxX - (safePaddle.size.width / 2)
    }
    
    private func isPaddlePositionTranspassingLeft(_ location: Double) -> Bool {
        guard let safePaddle = self.paddle else { return false }
        return location < frame.minX + (safePaddle.size.width / 2)
    }
}
