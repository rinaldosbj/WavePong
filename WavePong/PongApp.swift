//
//  DvdScreensaverApp.swift
//  DvdScreensaver
//
//  Created by rsbj on 18/10/22.
//

import SwiftUI

@main
struct PongApp: App {
    
    var body: some Scene {
        
        WindowGroup {
//            if #available(iOS 16.0, *) {
//                NavigationStack {
//                    OnboardingView()
//                }
//            }
//            else {
                NavigationView {
                    OnboardingView()
                }
                .navigationViewStyle(.stack)
//            }
        }
    }
}

