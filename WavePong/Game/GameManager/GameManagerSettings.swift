//
//  GameManagerSettings.swift
//  WavePong
//
//  Created by Lucas Migge on 04/09/23.
//

import Foundation

enum GameDifficulty: String, CaseIterable {
    case easy, medium, hard, extreme
}

struct GameManagerSettings {
    var difficulty: GameDifficulty
    
    var ballSpeed: CGVector
    var maxBallSpeed: CGFloat
    var cloudVelocity: Double
    var ballSize: CGSize
    var paddleProportion: Double
    
    init(difficulty: GameDifficulty) {
        self.difficulty = difficulty
        
        switch difficulty{
        case .easy:
            self.ballSpeed = CGVector(dx: 100, dy: 100)
            self.maxBallSpeed = 200
            self.cloudVelocity = 60
            self.ballSize = CGSize(width: 90, height: 90)
            self.paddleProportion = 1/2
           
        case .medium:
            self.ballSpeed = CGVector(dx: 200, dy: 200)
            self.maxBallSpeed = 400
            self.cloudVelocity = 40
            self.ballSize = CGSize(width: 80, height: 80)
            self.paddleProportion = 1/2.5
        case .hard:
            self.ballSpeed = CGVector(dx: 300, dy: 300)
            self.maxBallSpeed = 600
            self.cloudVelocity = 20
            self.ballSize = CGSize(width: 70, height: 70)
            self.paddleProportion = 1/2.75
        case .extreme:
            self.ballSpeed = CGVector(dx: 500, dy: 500)
            self.maxBallSpeed = 1000
            self.cloudVelocity = 5
            self.ballSize = CGSize(width: 60, height: 60)
            self.paddleProportion = 1/3
        }
    }
}
