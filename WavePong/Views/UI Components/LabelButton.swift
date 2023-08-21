//
//  LabelButton.swift
//  WavePong
//
//  Created by Lucas Migge on 16/08/23.
//

import Foundation
import SwiftUI

struct LabelButton: View {
    enum ButtonStyle: String {
        case start, resume
        
    }
    
    var buttonStyle: ButtonStyle
    var buttonAction: () -> Void
    
    
    // no futuro, a string deverá corresponder ao idioma
    var textLabel: String {
        switch buttonStyle {
        case .start:
            return "Começar"
        case .resume:
            return "Continuar"
        }
    }
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            ZStack {
                Image("BackgroundButton")
                    .resizable()
                    .scaledToFill()
                
                Text(textLabel)
                    .font(Font.WavePongPrimary(.body))
                    .foregroundColor(Color("WHITE"))
            }
            .frame(width: 282, height: 84)
        }
    }
    
    
}
