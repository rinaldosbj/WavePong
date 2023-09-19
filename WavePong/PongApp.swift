//
//  DvdScreensaverApp.swift
//  DvdScreensaver
//
//  Created by rsbj on 18/10/22.
//

import SwiftUI

@main
struct PongApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var notificationManager = NotificationManager.shared
    var player = Player.shared
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                
                if player.onboradingHappend {
                    MenuView()
                }
                else {
                    OnboardingView()
                }
            }
            .navigationViewStyle(.stack)
        }.onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                notificationManager.clearNotifications(notificationIdentifier: "Inactivity")
                print("App is active")
            case .inactive:
                notificationManager.scheduleNotifications()
                print("App is inactive")
            case .background:
                print("App is in background")
            @unknown default:
                print("Oh - interesting: I received an unexpected new value.")
            }
        }
    }
}
