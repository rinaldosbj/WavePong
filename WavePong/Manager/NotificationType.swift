//
//  NotificationTypes.swift
//  WavePong
//
//  Created by LoreVilaca on 17/08/23.
//

import Foundation
import SwiftUI

enum notificationType {
    
    case twoDays
    case oneWeek
    case twoWeek
    
    var identifier: String {
        switch self {
        case .twoDays:
            return "twoDaysInactivityNotification"
        case .oneWeek:
            return "oneWeekInactivityNotification"
        case .twoWeek:
            return "twoWeekInactivityNotification"
        }
    }
    
    var title: String {
        switch self {
        case .twoDays:
            return "Dois dias"
        case .oneWeek:
            return "Uma semana"
        case .twoWeek:
            return "Duas semanas"
        }
        
    }
    
    var body: String {
        switch self {
        case .twoDays:
            return "Você não entra no app há dois dias"
        case .oneWeek:
            return "Você não entra no app há uma semana"
        case .twoWeek:
            return "Você não entra no app há duas semanas"
        }
    }
    
    var timeInterval: TimeInterval {
        switch self {
        case .twoDays: //172800
            return 172800
        case .oneWeek: //604800
            return 604800
        case .twoWeek: //1209600
            return 1209600
        }
    }
    
    var repeats: Bool {
        switch self {
        case .twoDays:
            return false
        case .oneWeek:
            return false
        case .twoWeek:
            return true
        }
    }
    
    var sound: UNNotificationSound {
        switch self {
        case .twoDays:
            return .default
        case .oneWeek:
            return .default
        case .twoWeek:
            return .default
        }
    }
    
}
