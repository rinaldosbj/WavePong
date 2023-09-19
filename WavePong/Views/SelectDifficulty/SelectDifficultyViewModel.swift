//
//  SelectDifficultyViewModel.swift
//  WavePong
//
//  Created by Lucas Migge on 19/09/23.
//

import Foundation

class SelectDifficultyViewModel: ObservableObject {

    func viewModelToBePresented(selectedDifficulty: GameDifficulty) -> GameSceneViewModel {
        let gameManager = GameManagerFactory.createGameManager(selectedDifficulty)
        return GameSceneViewModel(gameManager: gameManager)
    }

    
}
