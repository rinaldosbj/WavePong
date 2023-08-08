//
//  AppDelegate.swift
//  WavePong
//
//  Created by LoreVilaca on 08/08/23.
//

import UIKit
import UserNotifications
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    @StateObject var notificationManager = NotificationManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print ("Foi")
        notificationManager.requestAuthorization()
        return true
    }
    
}
