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
        case settings, pause, start, gamecenter, home, refresh
    }
    
    var buttonStyle: ButtonStyle
    
    var buttonAction: () -> Void
    
    init(_ buttonStyle: ButtonStyle, buttonAction: @escaping () -> Void) {
        self.buttonStyle = buttonStyle
        self.buttonAction = buttonAction
    }
    
    private var buttonImageString: String {
        buttonStyle.rawValue
    }
    
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Image(buttonImageString)
                .resizable()
                .frame(width: 104, height: 104)
        }

        
    }
}


