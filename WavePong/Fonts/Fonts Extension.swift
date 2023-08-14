//
//  Fonts Extension.swift
//  WavePong
//
//  Created by Lucas Migge on 14/08/23.
//

import Foundation
import SwiftUI

extension Font {
    public enum WavePongPrimaryType {
        case h1, h2, headline, body, caption
        
    }
    
    static public func WavePongPrimary(_ type: WavePongPrimaryType) -> Font {
        
        let fontName: String = "DaysOne-Regular"
        
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
}
