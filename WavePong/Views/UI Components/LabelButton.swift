//
//  LabelButton.swift
//  WavePong
//
//  Created by Lucas Migge on 16/08/23.
//

import Foundation
import SwiftUI

struct LabelButton: View {
    
    let stringsConstants = StringsConstantsModel()
    
    enum ButtonStyle: String {
        case start, resume, easy, medium, hard, save
    }
    
    var buttonStyle: ButtonStyle
    var buttonAction: () -> Void
    
    
    // no futuro, a string deverá corresponder ao idioma
    var textLabel: String {
        switch buttonStyle {
        case .start:
            return stringsConstants.start
        case .resume:
            return stringsConstants.continuar
        case .easy:
            return stringsConstants.easy
        case .medium:
            return stringsConstants.medium
        case .hard:
            return stringsConstants.hard
        case .save:
            return stringsConstants.save
        }
    }
    
    var body: some View {
        switch buttonStyle {
        case .resume:
            Button {
                buttonAction()
            } label: {
                button
            }
        case .save:
            Button {
                buttonAction()
            } label: {
                buttonShort
            }
        default:
            button
        }
        
    }
    
    var button: some View {
        ZStack {
            Image("BackgroundButton")
                .resizable()
                .scaledToFill()
            
            Text(textLabel)
                .font(Font.wavePongPrimary(.body))
                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
        }
        .frame(width: 282, height: 84)
    }
    
    var buttonShort: some View {
        ZStack {
            Image("BackgroundButton")
                .resizable()
                .scaledToFill()
            
            Text(textLabel)
                .font(Font.wavePongPrimary(.body))
                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
        }
        .frame(width: 227, height: 84)
    }
}
