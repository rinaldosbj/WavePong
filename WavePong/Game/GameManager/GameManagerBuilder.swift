//
//  GameManagerBuilder.swift
//  WavePong
//
//  Created by Lucas Migge on 18/09/23.
//

import Foundation


class GameManagerFactory {
    
    static func createGameManager(_ difficulty: GameDifficulty) -> GameManager {
        switch difficulty {
        case .easy:
            return GameManager(gameDifficulty: .easy)
        case .medium:
            return GameManager(gameDifficulty: .medium)
        case .hard:
            return GameManager(gameDifficulty: .hard)
        case .extreme:
            return GameManager(gameDifficulty: .extreme)
        }
        
    }
}
