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
    enum ButtonType: String {
        case link, action
    }
    
    var buttonStyle: ButtonStyle
    var buttonType: ButtonType
    
    var buttonAction: () -> Void = {}
    
    init(_ buttonStyle: ButtonStyle, buttonType: ButtonType, buttonAction: @escaping () -> Void) {
        self.buttonStyle = buttonStyle
        self.buttonType = buttonType
        self.buttonAction = buttonAction
    }
    
    private var buttonImageString: String {
        buttonStyle.rawValue
    }
    
    
    var body: some View {
        switch buttonType {
        case .link:
            Image(buttonImageString)
                .resizable()
                .frame(width: 104, height: 104)
        case .action:
            Button {
                buttonAction()
            } label: {
                Image(buttonImageString)
                    .resizable()
                    .frame(width: 104, height: 104)
            }
        }
        
    }
}


