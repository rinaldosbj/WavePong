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
                        .foregroundColor(Color("amarelo"))
                        .padding(.all, 3)
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.15),value: configuration.isOn)
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
        
        
    }
}

struct SelectCustomToggleStyle: ToggleStyle {
    
    var mode: SoundMode
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            ZStack {
                configuration.label
                Color(UIColor(.white))
                    .frame(width: 20, height: 20, alignment: .center)
                    .border(Color("roxo"),width: 2)
                
                if configuration.isOn {
                    Text("X")
                        .foregroundColor(Color("roxo"))
                        .font(.custom("DaysOne-Regular", size: 20))
                        .frame(width: 20, height: 20, alignment: .center)
                }
                
            }
            
            switch mode {
            case .linear:
                Text("Linear")
                    .font(.custom("DaysOne-Regular", size: 24))
                    .foregroundColor(.white)
            case .curved:
                Text("Exponencial")
                    .font(.custom("DaysOne-Regular", size: 24))
                    .foregroundColor(.white)
            case .highContrast:
                Text("Alto contraste")
                    .font(.custom("DaysOne-Regular", size: 24))
                    .foregroundColor(.white)
            }
        }
        .onTapGesture { configuration.isOn.toggle() }
    }
}

