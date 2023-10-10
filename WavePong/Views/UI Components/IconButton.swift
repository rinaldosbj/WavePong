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
        switch buttonStyle {
        case .settings:
            return ImageConstants.shared.SETTINGS
        case .pause:
            return ImageConstants.shared.PAUSE
        case .start:
            return ImageConstants.shared.PLAY
        case .gameCenter:
            return ImageConstants.shared.GAME_CENTER
        case .home:
            return ImageConstants.shared.HOME
        case .refresh:
            return ImageConstants.shared.PLAY_AGAIN
        }
    }
    
    
    private var buttonIconSizes: [Double] {
        switch buttonStyle {
        case .settings:
            return [50, 52.3]
        case .pause:
            return [40, 50]
        case .start:
            return [40, 46]
        case .gameCenter:
            return [43.5, 52]
        case .home:
            return [60,54]
        case .refresh:
            return [60.8,51.2]
        }
        
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
        
        ZStack {
            
            Rectangle()
                .fill(Color(ColorConstants.shared.WHITE_500))
                .roundedCorner(24,corners: [.topLeft, .bottomRight])
                .frame(width: 104, height: 104)
            
            Rectangle()
                .fill(Color(ColorConstants.shared.PURPLE_500))
                .roundedCorner(23,corners: [.topLeft, .bottomRight])
                .frame(width: 101, height: 101)
                .overlay(
                    Image(buttonImageString)
                        .resizable()
                        .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                        .frame(width: buttonIconSizes[0], height: buttonIconSizes[1])
                        .padding(20)
                )
            
        }
    }
}
