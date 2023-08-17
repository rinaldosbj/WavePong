//
//  GameSceneViewModel.swift
//  WavePong
//
//  Created by Lucas Migge on 16/08/23.
//

import Foundation

class GameSceneViewModel: ObservableObject, GameManagerDelegate {
    
    @Published var size: CGSize = CGSize()
    @Published var state: ViewMode = .game
    
    var gameManager: GameManager
    
    var pauseButtonDelegate: GameManagerDelegate?
    
    init(gameManager: GameManager = GameManager()) {
        self.gameManager = gameManager
        self.gameManager.pauseButtonDelegate = self
        
    }
    
    func didGameViewApper() {
        self.gameManager.startGame()
        
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
    }
    
}
