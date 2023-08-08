//
//  NotificationManager.swift
//  WavePong
//
//  Created by LoreVilaca on 07/08/23.
//

import SwiftUI
import UserNotifications
import NotificationCenter

class NotificationManager: ObservableObject {
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization (){
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }
}
