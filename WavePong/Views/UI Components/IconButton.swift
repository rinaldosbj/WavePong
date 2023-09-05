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
                    Image(systemName: "play.fill")
                        .resizable()
                        .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                        .padding(22)
                )
            
        }
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
