//
//  GameCenterManager.swift
//  WavePong
//
//  Created by LoreVilaca on 22/08/23.
//

import GameKit
import SwiftUI

class GameCenterManager {
    
    static let shared = GameCenterManager()
    
    private let LEADERBOARD_ID: String = "recordWavePong"
    private let localPlayer = GKLocalPlayer.local

    func isPlayerAuthenticated () -> Bool {
        if localPlayer.isAuthenticated {
            return true
        } else {
            return false
        }
    }
    
    func getLeaderbordID () -> String {
        return LEADERBOARD_ID
    }
    
    func authenticatePlayer () {
        localPlayer.authenticateHandler = { vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            } 
        }
    }
    
    
    func submitScore (with value: Int) {
        GKLeaderboard.submitScore(value, context: 0, player: self.localPlayer,
                                  leaderboardIDs: [self.LEADERBOARD_ID]) { error in
            if error != nil {
                print("Error: \(error!.localizedDescription).")
            } else {
                print ("Novo recorde registrado")
            }
        }
    }
}

