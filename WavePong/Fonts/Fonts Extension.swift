//
//  Fonts Extension.swift
//  WavePong
//
//  Created by Lucas Migge on 14/08/23.
//

import Foundation
import SwiftUI

extension Font {
    struct CustonFonts {
        static var daysOne = "DaysOne-Regular"
        static var strasua = "strasua"
    }
    
    public enum WavePongPrimaryType {
        case h1, h2, headline, body, caption
        
    }
    
    public enum WavePongSecundaryType {
        case scoreNumber, score
    }
    
    static public func wavePongPrimary(_ type: WavePongPrimaryType) -> Font {
        
        let fontName: String = CustonFonts.daysOne
        
        switch type {
            
        case .h1:
            return .custom(fontName, size: 96)
        case .h2:
            return .custom(fontName, size: 32)
        case .headline:
            return .custom(fontName, size: 36)
        case .body:
            return .custom(fontName, size: 24)
        case .caption:
            return .custom(fontName, size: 16)
        }
        
    }
    
    static public func wavePongSecundary(_ type: WavePongSecundaryType) -> Font {
        
        let fontName: String = CustonFonts.strasua
        
        switch type {
        case .scoreNumber:
            return .custom(fontName, size: 146)
            
        case .score:
            return .custom(fontName, size: 24)
        }
        
    }
}
