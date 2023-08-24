//
//  GameSceneViewModel.swift
//  WavePong
//
//  Created by Lucas Migge on 16/08/23.
//

import Foundation

class GameSceneViewModel: ObservableObject, GameManagerDelegate {
    var soundManager: SoundManager
    var hapticManager: HapticsManager
    
    @Published var size: CGSize = CGSize()
    @Published var state: ViewMode = .game
    @Published var userScore: String = ""
    @Published var recordLabel: String = ""
        
    static let shared = GameSceneViewModel()
    
    var gameManager: GameManager
    
    var pauseButtonDelegate: GameManagerDelegate?
    
    init(gameManager: GameManager = GameManager(), soundManager: SoundManager = SoundManager.shared,
         hapticsManager: HapticsManager = HapticsManager.shared) {
        self.gameManager = gameManager
        self.soundManager = soundManager
        self.hapticManager = hapticsManager
        self.gameManager.gameManagerDelegate = self
        
    }
    
    enum ViewMode {
        case game, pause, gameOver
    }
    
    
    func pauseNodePressed() {
        state = .pause
    }
    
    func pauseTap() {
        if gameManager.canPause {
            gameManager.pauseButtonPressed()
            state = .pause
        }
        
    }
    
    func continueButtonPressed() {
        gameManager.resumeGame()
        state = .game
    }
    
    func refreshPressed() {

        gameManager.resetGame()
        state = .game
    } 
    
    
    func gameOver(scoreLabel: String, recordLabel: String) {
        self.userScore = scoreLabel
        self.recordLabel = recordLabel
        state = .gameOver
    }
    
    
    func homeButtonPressed() {
        gameManager.restoreGameManager()
        state = .game
    }
}
