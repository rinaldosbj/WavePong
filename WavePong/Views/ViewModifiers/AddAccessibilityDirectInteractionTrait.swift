//
//  AddAccessibilityDirectInteractionTrait.swift
//  WavePong
//
//  Created by rsbj on 23/08/23.
//

import SwiftUI

/// View modifier that allows to change externaly the allowsDirectInteraction trait (for VoiceOver)
struct AddAccessibilityDirectInteractionTrait: ViewModifier {
    var condition: Bool
    
    func body(content: Content) -> some View {
        if condition {
            return content
                .accessibilityHidden(false)
                .accessibilityAddTraits(.allowsDirectInteraction)
        } else {
            return content
                .accessibilityRemoveTraits(.allowsDirectInteraction)
                .accessibilityHidden(true)
        }
    }
}
