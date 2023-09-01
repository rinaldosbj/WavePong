//
//  HapticsManager.swift
//  WavePong
//
//  Created by Lucas Migge on 05/08/23.
//

import Foundation
import UIKit

/// Object responsable for feedback vibrations
public final class HapticsManager: HapticsManagerProtocol {
    
    /// instance for accessing features
    static let shared: HapticsManagerProtocol = HapticsManager()
    
    private init() {}
    
    /// when called, produces a standard vibration
    public func vibrate() {
        DispatchQueue.main.async {
            let selectionFeedbackGeneretor = UISelectionFeedbackGenerator()
            selectionFeedbackGeneretor.prepare()
            selectionFeedbackGeneretor.selectionChanged()
        }
        
    }
    
    /// Methods for vibrations of type Success, Error or Warning
    public func vibrateNotification(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
      
    }
    
    /// Methods for vibrations made for simulating physics Impact
    ///
    /// - Parameter type: must chose one of the feedback styles available
    /// - Parameter intensity: must be a value from 0 - 1
    public func vibrateImpact(for type: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat) {
        let impactNotificiationGenerator = UIImpactFeedbackGenerator(style: type)
        impactNotificiationGenerator.prepare()
        impactNotificiationGenerator.impactOccurred(intensity: intensity)
    }
    
    
    
}

protocol HapticsManagerProtocol {
    
    static var shared: HapticsManagerProtocol { get }
    
    func vibrate()
    
    func vibrateNotification(for type: UINotificationFeedbackGenerator.FeedbackType)
    
    func vibrateImpact(for type: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat)
    
}
