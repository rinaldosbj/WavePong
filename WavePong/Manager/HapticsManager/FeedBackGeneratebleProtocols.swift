//
//  FeedBackGeneratebleProtocols.swift
//  WavePong
//
//  Created by Lucas Migge on 15/09/23.
//

import Foundation
import UIKit


protocol SelectionFeedbackGeneratable {
    func prepare()
    
    func selectionChanged()
    
}

extension UISelectionFeedbackGenerator: SelectionFeedbackGeneratable {
    
}

protocol NotificationFeedbackGeneratable {
    func prepare()
    
    func notificationOccurred(_ notificationType: UINotificationFeedbackGenerator.FeedbackType)
}

extension UINotificationFeedbackGenerator: NotificationFeedbackGeneratable {
    
}

protocol ImpactFeedbackGeneratable {
    init(style: UIImpactFeedbackGenerator.FeedbackStyle)
    
    func prepare()
    
    func impactOccurred(intensity: CGFloat)
    
}

extension UIImpactFeedbackGenerator: ImpactFeedbackGeneratable {
    
}
