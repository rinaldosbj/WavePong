//
//  GameSceneViewModel.swift
//  WavePong
//
//  Created by Lucas Migge on 16/08/23.
//

import Foundation


enum GameSceneViewState {
    case game, pause, gameOver
}

class GameSceneViewModel: ObservableObject {


    @Published var size: CGSize = CGSize()
    @Published var state: GameSceneViewState = .game
    @Published var userScore: String = ""
    @Published var recordLabel: String = ""
    
    
    var gameManager: GameManager

    init(gameManager: GameManager) {
        self.gameManager =  gameManager
        self.gameManager.gameManagerDelegate = self
    }
    
    /// Once that user double tapped the game Screen, it should pause game and music
    func pauseTap() {
        if gameManager.canPause {
            gameManager.pauseTrigger()
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
    
    func appWillMoveToBackground() {
        gameManager.didLose()
        state = .gameOver
        
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
