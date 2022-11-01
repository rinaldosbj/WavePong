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
        var contentView = ContentView()
        
        WindowGroup {
            if contentView.record >= 1 {
                ContentView()
            }
            else{
                ColoqueFone()
            }
        }
    }
}
