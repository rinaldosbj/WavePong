//
//  LeaderboardView.swift
//  WavePong
//
//  Created by LoreVilaca on 22/08/23.
//

import SwiftUI
import GameKit

/// Displayes Game Center
struct GameCenterView: UIViewControllerRepresentable {
    let gameCenter = GameCenterManager.shared
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        let gcVC = GKGameCenterViewController(leaderboardID: gameCenter.getLeaderbordID(), playerScope: .global, timeScope: .allTime)
        gcVC.gameCenterDelegate = context.coordinator
        return gcVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//         Atualiza a visualização, se necessário
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, GKGameCenterControllerDelegate {
        var parent: GameCenterView
        
        init(_ parent: GameCenterView) {
            self.parent = parent
        }
        
        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true)
            parent.isPresented = false
        }
    }
}

