//
//  GameManager.swift
//  WavePong
//
//  Created by rsbj on 01/08/23.
//

import SpriteKit

class GameManager {
    var isGameRunning: Bool = true
    var score: Int = 0
    
    var physicsDetection = PhysicsDetection()
    var sceneDelegate: GameSceneProtocol?
    
    public var colors: [UIColor] = [UIColor.blue,UIColor.cyan,UIColor.green]
    
    init() {
        self.physicsDetection.gameActionDelegate = self
        
    }
    
}

extension GameManager: GameActionDelegate {
    func incrementScore(){
        score += 1
        print("incrementou score")
        sceneDelegate?.didUserScored(newScore: score)
    
    }
    
    func didLose() {
        isGameRunning = false
        // implementa a lógica quando o jogador perde
        // pause ou renincia
        // apresenta tela "GAME OVER"
        // ...
    }
}


