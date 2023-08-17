//
//  DvdScreensaverApp.swift
//  DvdScreensaver
//
//  Created by rsbj on 18/10/22.
//

import SwiftUI

@main
struct PongApp: App {
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
        }
    }
}

