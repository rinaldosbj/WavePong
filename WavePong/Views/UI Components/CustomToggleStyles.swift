//
//  CustomToggleStyles.swift
//  WavePong
//
//  Created by rsbj on 28/08/23.
//

import SwiftUI

struct NotificationsCustomToggleStyle: ToggleStyle {
    var onColor: UIColor
    var offColor: UIColor
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Color(configuration.isOn ? onColor : offColor)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(Color(ColorConstants.shared.YELLOW_600))
                        .padding(.all, 3)
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.15),value: configuration.isOn)
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
        
        
    }
}
