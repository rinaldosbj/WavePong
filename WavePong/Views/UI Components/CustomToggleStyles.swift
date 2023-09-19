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

struct SelectCustomToggleStyle: ToggleStyle {
    
    let stringsConstants = StringsConstantsModel()

    var mode: SoundMode
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            ZStack {
                Color(ColorConstants.shared.WHITE_500)
                    .frame(width: 24, height: 24, alignment: .center)
                    .border(Color(ColorConstants.shared.PURPLE_500),width: 2)
                
                if configuration.isOn {
                    Text("X")
                        .foregroundColor(Color(ColorConstants.shared.PURPLE_500))
                        .font(Font.wavePongPrimary(.body))
                        .frame(width: 24, height: 24, alignment: .center)
                }
                
            }
            
            switch mode {
            case .linear:
                Text(stringsConstants.linear)
                    .font(Font.wavePongPrimary(.body))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
            case .curved:
                Text(stringsConstants.exponencial)
                    .font(Font.wavePongPrimary(.body))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
            case .highContrast:
                Text(stringsConstants.alto)
                    .font(Font.wavePongPrimary(.body))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
            }
        }
        .onTapGesture { configuration.isOn.toggle() }
    }
}

