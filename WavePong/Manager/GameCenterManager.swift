//
//  GameCenterManager.swift
//  WavePong
//
//  Created by LoreVilaca on 22/08/23.
//

import GameKit

class GameCenterManager: ObservableObject {
    let localPlayer = GKLocalPlayer.local
    
    func authenticatePlayer () {
        localPlayer.authenticateHandler = { vc, error in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
            }
    }
    
//    func loadLeaderboard() async {
//        playersList.removeAll()
//        Task{
//            var playersListTemp : [Player] = []
//            let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier])
//            if let leaderboard = leaderboards.filter ({ $0.baseLeaderboardID == self.leaderboardIdentifier }).first {
//                let allPlayers = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...5))
//                if allPlayers.1.count > 0 {
//                    try await allPlayers.1.asyncForEach { leaderboardEntry in
//                        var image = try await leaderboardEntry.player.loadPhoto(for: .small)
//                        playersListTemp.append(Player(name: leaderboardEntry.player.displayName, score:leaderboardEntry.formattedScore, image: image))
//                                    print(playersListTemp)
//                        playersListTemp.sort{
//                            $0.score < $1.score
//                        }
//                    }
//                }
//            }
//            playersList = playersListTemp
//        }
//    }
    
    func submitScore (
}
