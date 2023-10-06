//
//  AnalyticsManager.swift
//  WavePong
//
//  Created by Lucas Migge on 04/09/23.
//

import Foundation
import Firebase

final class AnalyticsManager {
    
    public func logGameSession(panStyle: SoundMode, dificulty: GameDifficulty) {
        
        let soundMode: String = convertPanStyleToString(panStyle)
        
        Analytics.logEvent("match_session", parameters: [
            "difficulty" : dificulty.rawValue as NSObject,
            "sound_mode" : soundMode as NSObject,
        ])
    }
    
    public func logGameScore(score: Int,  dificulty: GameDifficulty) {
        Analytics.logEvent("game_score", parameters: [
            "score" : score as NSObject,
            "difficulty" : dificulty.rawValue as NSObject
        ])
    }
    
    
    private func convertPanStyleToString(_ panStyle: SoundMode) -> String {
        switch panStyle {
        case .linear:
            return "linear"
        case .highContrast:
            return "highConstrast"
        }
    }
}
