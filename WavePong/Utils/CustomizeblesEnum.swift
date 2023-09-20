//
//  BallTypesEnum.swift
//  WavePong
//
//  Created by rsbj on 06/09/23.
//

enum PreviousBallSkin: Int, CaseIterable {
    case ball_yellow, ball_green, ball_cyan, ball_blue, ball_purple, ball_red, ball_orange
}






enum ThemeStyle: Int {
    case defaultTheme, theme2, theme3
}


protocol Clouds {
    var cloud1: String { get }
    var cloud2: String { get }
    var cloud3: String { get }
}

struct DefaultClouds: Clouds {
    var cloud1 = "Cloud1variation1"
    var cloud2 = "Cloud2variation1"
    var cloud3 = "Cloud3variation1"
    
    
}

struct VariationClouds1: Clouds {
    var cloud1 = "Cloud1variation2"
    var cloud2 = "Cloud2variation2"
    var cloud3 = "Cloud3variation2"
}


class CloudStyleFactory {
    static func createCloud(theme: ThemeStyle) -> Clouds {
        switch theme {
        case .defaultTheme:
            return DefaultClouds()
        case .theme2:
            return VariationClouds1()
        case .theme3:
            
        }
        
        
    }
}

struct CloudSkinmn {
    
    var theme: ThemeStyle
    var cloud1: String
    var cloud2: String
    var cloud3: String
    
    init(theme: ThemeStyle) {
        self.theme = theme
        
        switch theme {
        case .defaultTheme:
            cloud1 = "Cloud1variation1"
            cloud2 = "Cloud2variation1"
            cloud3 = "Cloud3variation1"
        case .theme2:
            cloud1 = "Cloud1variation2"
            cloud2 = "Cloud2variation2"
            cloud3 = "Cloud3variation2"
        case .theme3:
            
        }
    }
    
}

struct SoundKit {
    
    var theme: ThemeStyle
    var soundTrack: String
    var fxSoundHitPaddle: FXSounds
    var fxSoundLose: FXSounds
    var fxSoundRecord: FXSounds
    
    init(theme: ThemeStyle) {
        self.theme = theme
        switch theme {
        case .defaultTheme:
            soundTrack = "blablabla"
            fxSoundHitPaddle = .alert
            fxSoundLose = .alert
            fxSoundRecord = .alert
        case .theme2:
            soundTrack = "blablabla"
            fxSoundHitPaddle = .alert
            fxSoundLose = .alert
            fxSoundRecord = .alert
        }
    }
}





























































class ThemeFactory {
    static func createTheme(theme: ThemeStyle) -> Theme {
        switch theme {
        case .defaultTheme:
            return DefaultTheme()
        case .theme2:
            return Variation1Theme()
        }
    }
}

protocol Theme {
    
    var backgroundSkin: String { get }
    var ballSkin: String { get }
    var paddleSkin: String { get }
    var cloudSkin: CloudSkin { get }
    var soundKit: SoundKit { get }
    
}

class DefaultTheme: Theme {
    var backgroundSkin: String =  "BackgroundVariation1"
    
    var ballSkin: String = "BallVariation1"
    
    var paddleSkin: String = "PaddleVariation1"
    
    var cloudSkin: CloudSkin = CloudSkin(theme: .defaultTheme)
    
    var soundKit: SoundKit = SoundKit(theme: .defaultTheme)
}

class Variation1Theme: Theme {
    var backgroundSkin: String =  "BackgroundVariation1"
    
    var ballSkin: String = "BallVariation1"
    
    var paddleSkin: String = "PaddleVariation1"
    
    var cloudSkin: CloudSkin = CloudSkin(theme: .theme2)
    
    var soundKit: SoundKit = SoundKit(theme: .theme2)
}
