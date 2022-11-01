//
//  SpriteFiles+Vibrations.swift
//  DvdScreensaver
//
//  Created by rsbj on 01/11/22.
//

import AVFoundation
import SwiftUI

extension UIDevice {
    static func vibrate() {
        let generator = UINotificationFeedbackGenerator() // Generator for the vibration
        generator.notificationOccurred(.success)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
