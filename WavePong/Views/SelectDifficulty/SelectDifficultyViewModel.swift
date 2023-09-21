//
//  SelectDifficultyViewModel.swift
//  WavePong
//
//  Created by Lucas Migge on 19/09/23.
//

import Foundation

class SelectDifficultyViewModel: ObservableObject {
    
    let stringsConstants = StringsConstantsModel()
    
    var labelDifficulty: String {
        stringsConstants.dificuldade
        
    }
    
    var labelDifficultyHint: String {
        stringsConstants.dificuldade_hint
    }
    
    var labelReturn: String {
        stringsConstants.volta
    }
    
    var labelReturnHint: String {
        stringsConstants.volta_hint
    }

    func viewModelToBePresented(selectedDifficulty: GameDifficulty) -> GameSceneViewModel {
        let gameManager = GameManagerFactory.createGameManager(selectedDifficulty)
        return GameSceneViewModel(gameManager: gameManager)
    }

    
}
