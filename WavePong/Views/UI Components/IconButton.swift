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
    enum ButtonType: String {
        case action, link
    }
    
    var buttonStyle: ButtonStyle
    
    var buttonType: ButtonType
    
    var buttonAction: () -> Void
    
    init(_ buttonStyle: ButtonStyle, buttonType: ButtonType = .action, buttonAction: @escaping () -> Void) {
        self.buttonStyle = buttonStyle
        self.buttonType = buttonType
        self.buttonAction = buttonAction
    }
    
    private var buttonImageString: String {
        buttonStyle.rawValue
    }
    
    
    var body: some View {
        switch buttonType{
        case .action:
            Button {
                buttonAction()
            } label: {
                button
            }
        case .link:
                button
        }
        
    }
    
    var button: some View {
        Image(buttonImageString)
            .resizable()
            .frame(width: 104, height: 104)
    }
}


