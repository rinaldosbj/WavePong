//
//  HapticsManager.swift
//  WavePong
//
//  Created by Lucas Migge on 05/08/23.
//

import Foundation
import UIKit

/// Object responsable for feedback vibrations
public final class HapticsManager {
    
    /// instance for accessing features
    static let shared = HapticsManager()
    
    private init() {}
    
    /// when called, produces a standard vibration
    public func selectionVibrate() {
        DispatchQueue.main.async {
            let selectionFeedbackGeneretor = UISelectionFeedbackGenerator()
            selectionFeedbackGeneretor.prepare()
            selectionFeedbackGeneretor.selectionChanged()
        }
        
    }
    
    /// Methods for vibrations of type Success, Error or Warning
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
      
    }
    
    
    
}
