//
//  GameManager.swift
//  WavePong
//
//  Created by rsbj on 01/08/23.
//

import SpriteKit

class GameManager{
    var didLose: Bool = false
    var score: Int = 0
    private var scene: SKScene
    
    private var colors: [UIColor] = [UIColor.blue,UIColor.cyan,UIColor.green]
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func incrementScore(){
        score += 1
        scene.backgroundColor = colors[Int.random(in: 0..<3)]
    }
    
    func startPongGame(ball: Ball, cloud: SKSpriteNode){
        ball.run(SKAction.applyImpulse(CGVector(dx: 15, dy: 15), duration: 1))
        cloud.run(SKAction.move(to: CGPoint(x: scene.frame.midX, y: scene.frame.midY + 100), duration: 20))
    }
}
