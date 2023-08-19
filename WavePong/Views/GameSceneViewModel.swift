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
    
    var gameManager: GameManager
    
    var pauseButtonDelegate: GameManagerDelegate?
    
    init(gameManager: GameManager = GameManager(), soundManager: SoundManager = SoundManager.shared) {
        self.gameManager = gameManager
        self.soundManager = soundManager
        self.gameManager.pauseButtonDelegate = self
        
    }
    
    enum ViewMode {
        case game, pause
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
        soundManager.stopGameTheme()
        gameManager.startGame()
    }
    
    
    func homeButtonPressed() {
        soundManager.stopGameTheme()
        state = .game
    }
}
