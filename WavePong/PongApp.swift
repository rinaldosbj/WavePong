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
    
    var onboard = OnboardingManager()
    
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var notificationManager = NotificationManager.shared

    var body: some Scene {
        
        WindowGroup {
            ZStack {
                HomeButtonHiden
                NavigationView {
                    if onboard.onboradingHappend {
                        MenuView()
                    }
                    else {
                        OnboardingView(for: .main)
                    }
                }
                .navigationViewStyle(.stack)
            }
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

extension PongApp {
//  Gambs to Hide the Home button in the app
    var HomeButtonHiden: some View {
        ZStack { Text("")
        if #available(iOS 16.0, *) { Text("")
                    .persistentSystemOverlays(.hidden) }
        }
    }
}
