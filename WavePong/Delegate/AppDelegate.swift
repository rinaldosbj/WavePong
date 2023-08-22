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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notificationManager.requestNotificationAuthorization()
        FirebaseApp.configure()
        return true
    }
}
