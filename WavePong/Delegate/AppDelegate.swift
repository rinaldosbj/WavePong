//
//  AppDelegate.swift
//  WavePong
//
//  Created by LoreVilaca on 08/08/23.
//

import UIKit
import SwiftUI
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    @ObservedObject var notificationManager = NotificationManager.shared
    let gameCenter = GameCenterManager.shared
    let chipManager = ChipManager.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notificationManager.requestNotificationAuthorization()
        chipManager.loadChips()
        print ("Você tinha essas moedas quando carregou o jogo:")
        print(UserDefaults.standard.integer(forKey: chipManager.chipKey))
//        gameCenter.authenticatePlayer()
        FirebaseApp.configure()
        return true
    }
}
