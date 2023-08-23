//
//  LeaderboardView.swift
//  WavePong
//
//  Created by LoreVilaca on 22/08/23.
//

import SwiftUI

struct LeaderboardView: View {
    
    var body: some View {
        ZStack {
            Text ("HighScore")
            
        }.onAppear(){
            if !GKLocalPlayer.local.isAuthenticated {
                  authenticateUser()
              } else if playersList.count == 0 {
                  Task{
                      await loadLeaderboard()
                  }
              }
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
