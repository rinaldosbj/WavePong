//
//  GameSceneViewModel.swift
//  WavePong
//
//  Created by Lucas Migge on 16/08/23.
//

import Foundation

class GameSceneViewModel: ObservableObject {
    enum ViewMode {
        case game, pause, gameOver
    }
    
    @Published var size: CGSize = CGSize()
    @Published var state: ViewMode = .game
    @Published var userScore: String = ""
    @Published var recordLabel: String = ""
    
    /// Instance for accessing the logic layer of the gameScene
    var gameManager: GameManager

    init(gameManager: GameManager) {
        self.gameManager = gameManager
        self.gameManager.gameManagerDelegate = self
        
    }
    
    /// Once that user double tapped the game Screen, it should pause game and music
    func pauseTap() {
        if gameManager.canPause {
            gameManager.pauseButtonPressed()
            state = .pause
        }

    }

    /// When game is paused, user can resume the game when continue button is pressed
    func continueButtonPressed() {
        gameManager.resumeGame()
        state = .game
    }

    
    func refreshPressed() {
        gameManager.resetGame()
        state = .game
        
    }

    func homeButtonPressed() {
        gameManager.restoreGameManager()
        state = .game
        
    }
}



extension GameSceneViewModel: GameManagerDelegate {
        func pauseNodePressed() {
            state = .pause
            
        }
    
    func gameOver(scoreLabel: String, recordLabel: String) {
        self.userScore = scoreLabel
        self.recordLabel = recordLabel
        state = .gameOver
        
    }
    
    
}
