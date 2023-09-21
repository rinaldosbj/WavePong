//
//  SelectDifficultyLabel.swift
//  WavePong
//
//  Created by Lucas Migge on 19/09/23.
//

import SwiftUI

struct SelectDifficultyLabel: View {
    
    let stringsConstatns = StringsConstantsModel()
    
    var difficulty: GameDifficulty
    
    var textLabel: String {
        switch difficulty {
        case .easy:
            return stringsConstatns.easy
        case .medium:
            return stringsConstatns.medium
        case .hard:
            return stringsConstatns.hard
        }
    }
    
    
    var body: some View {
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
}


#Preview {
    SelectDifficultyLabel(difficulty: .easy)
}
