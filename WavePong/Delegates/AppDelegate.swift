//
//  AppDelegate.swift
//  WavePong
//
//  Created by LoreVilaca on 08/08/23.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let notificationManager = NotificationManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notificationManager.requestAuthorization()
        return true
    }
    
}
