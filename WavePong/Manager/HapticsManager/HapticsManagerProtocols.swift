//
//  HapticsManagerProtocols.swift
//  WavePong
//
//  Created by Lucas Migge on 15/09/23.
//

import Foundation
import UIKit

protocol HapticsManagerProtocol {
    
    static var shared: HapticsManagerProtocol { get }
    
    func vibrate()
    
    func vibrateNotification(for type: UINotificationFeedbackGenerator.FeedbackType)
    
    func vibrateImpact(for type: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat)
    
}
