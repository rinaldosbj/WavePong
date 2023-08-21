//
//  GameSceneViewModel.swift
//  WavePong
//
//  Created by Lucas Migge on 16/08/23.
//

import Foundation

class GameSceneViewModel: ObservableObject, GameManagerDelegate {
    var soundManager: SoundManager
    
    @Published var size: CGSize = CGSize()
    @Published var state: ViewMode = .game
    @Published var userScore: String = ""
    @Published var recordLabel: String = ""
    
    var gameManager: GameManager
    
    var pauseButtonDelegate: GameManagerDelegate?
    
    init(gameManager: GameManager = GameManager(), soundManager: SoundManager = SoundManager.shared) {
        self.gameManager = gameManager
        self.soundManager = soundManager
        self.gameManager.gameManagerDelegate = self
        
    }
    
    enum ViewMode {
        case game, pause, gameOver
    }
    
    
    func pauseButtonPressed() {
        state = .pause
        
    }
    
    func continueButtonPressed() {
        gameManager.resumeGame()
        state = .game
    }
    
    func refreshPressed() {
        state = .game

    }
    
    func gameOver(scoreLabel: String, recordLabel: String) {
        self.userScore = scoreLabel
        self.recordLabel = recordLabel
        state = .gameOver
    }
    
    
    func homeButtonPressed() {
        soundManager.stopGameTheme()
        state = .game
    }
}
