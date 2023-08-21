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
    @Published var state: ViewMode = .countDown
    @Published var userScore: String = ""
    @Published var recordLabel: String = ""
    @Published var count: String = "3"
    
    var isInGame = false
    
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
        case game, pause, gameOver, countDown
    }
    
    
    func pauseButtonPressed() {
        state = .pause
        
    }
    
    func continueButtonPressed() {
        gameManager.resumeGame()
        state = .game
    }
    
    func refreshPressed() {
        count = "3"
        state = .countDown
    } 
    
    
    func gameOver(scoreLabel: String, recordLabel: String) {
        self.userScore = scoreLabel
        self.recordLabel = recordLabel
        state = .gameOver
    }
    
    
    func homeButtonPressed() {
        soundManager.stopGameTheme()
        refreshPressed()
    }
    
    func countDown() {
        hapticManager.vibrate()
        if isInGame {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                if count == "GO!" {
                    state = .game
                    gameManager.startGame()
                    
                }
                else if count == "1" {
                    count = "GO!"
                }
                else {
                    count = String(Int(count)! - 1)
                }
            }
        }
    }
}
