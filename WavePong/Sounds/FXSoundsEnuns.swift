//
//  FXSoundsEnuns.swift
//  WavePong
//
//  Created by Lucas Migge on 01/08/23.
//

import Foundation

/// Type for representing a FX Sound file on project
///
/// Each case name must match a audio file name
public enum FXSounds: String, CaseIterable {
    
    case bonus, horse, shooting, slimejump, success, transition, winter, alert, bounce, cuteClick, failed, hehe, mouse, surprise, winzinho, countDownBip, countDownEnd, explosion, pickupCoin
}

enum SoundMode: Int {
    case linear, curved, highContrast
}

//public enum SoundTrack: String, CaseIterable
