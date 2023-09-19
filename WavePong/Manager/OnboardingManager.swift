//
//  OnboardingController.swift
//  WavePong
//
//  Created by rsbj on 18/09/23.
//

import SwiftUI

class OnboardingManager: OnboardingProtocol,ObservableObject {
    
    private let defaults: UserDefaultable
    
    init(defaults: UserDefaultable = UserDefaults.standard) {
        self.defaults = defaults
    }
    
    private struct Constants {
        static var hasSeenOnboarding = "hasSeenOnboarding"
    }
    
    ///  Informs if the user already seen onboarding
    var onboradingHappend: Bool {
        return defaults.bool(forKey: Constants.hasSeenOnboarding)
    }
    
    /// Once player finishes onboarding, this methods must be called so the app won't show onboading every launch
    func userFinishedOnboarding() {
        defaults.set(true, forKey: Constants.hasSeenOnboarding)
    }
    
}

protocol OnboardingProtocol {
    /// Should return true if the user didn't seen onboarding yet
    var onboradingHappend: Bool { get }
    
    /// Must be used for updating the info that user has seen onboarding and shouldn't show it anymore on launch
    func userFinishedOnboarding()
    
}
