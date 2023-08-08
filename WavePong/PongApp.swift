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
    
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                MenuView()
            }
        }
    }
}
