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
    
    let selectionFeedback: SelectionFeedbackGeneratable
    let notificationFeedback: NotificationFeedbackGeneratable
    var impactFeedbackFactory: ImpactFeedbackGeneratorFactoryProtocol
    
    init(selectionFeedback: SelectionFeedbackGeneratable = UISelectionFeedbackGenerator(),
         notificationFeedback: NotificationFeedbackGeneratable = UINotificationFeedbackGenerator(),
         impactFeedbackFactory: ImpactFeedbackGeneratorFactoryProtocol = ImpactFeedbackGeneratorFactory()
    ) {
        self.selectionFeedback = selectionFeedback
        self.notificationFeedback = notificationFeedback
        self.impactFeedbackFactory = impactFeedbackFactory
    }
    
    /// when called, produces a standard vibration
    public func vibrate() {
        DispatchQueue.main.async {
            self.selectionFeedback.prepare()
            self.selectionFeedback.selectionChanged()
        }
        
    }
    
    /// Methods for vibrations of type Success, Error or Warning
    public func vibrateNotification(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            self.notificationFeedback.prepare()
            self.notificationFeedback.notificationOccurred(type)
        }
        
    }
    
    /// Methods for vibrations made for simulating physics Impact
    ///
    /// - Parameter type: must chose one of the feedback styles available
    /// - Parameter intensity: must be a value from 0 - 1
    public func vibrateImpact(for type: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat) {
        DispatchQueue.main.async {
            let impactFeedback = self.impactFeedbackFactory.createImpactFeedbackGenerator(withStyle: type)
            impactFeedback.prepare()
            impactFeedback.impactOccurred(intensity: intensity)
        }
    }
    
}




