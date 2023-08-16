//
//  IconButton.swift
//  WavePong
//
//  Created by Lucas Migge on 16/08/23.
//

import Foundation
import SwiftUI

struct IconButton: View {
    
    enum ButtonStyle: String {
        case settings, pause, start, gameCenter, home, refresh
    }
    
    var buttonStyle: ButtonStyle
    
    var buttonAction: () -> Void
    
    private var buttonImageString: String {
        buttonStyle.rawValue
    }
    
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Image(buttonImageString)
        }
        
    }
}
