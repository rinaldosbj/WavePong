//
//  BallTypesEnum.swift
//  WavePong
//
//  Created by rsbj on 06/09/23.
//

enum PreviousBallSkin: Int, CaseIterable {
    case ball_yellow, ball_green, ball_cyan, ball_blue, ball_purple, ball_red, ball_orange
}

enum Theme: Int {
    case defaultTheme, theme2, theme3
}

struct CloudSkin {
    
    var theme: Theme
    var cloud1: String
    var cloud2: String
    var cloud3: String
    
    init(theme: Theme) {
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
        }
    }
    
}

struct BallSkin {
    
    var theme: Theme
    var ball: String
    
    init(theme: Theme) {
        self.theme = theme
        
        switch theme {
        case .defaultTheme:
            ball = "BallVariation1"
        case .theme2:
            ball = "BallVariation2"
        }
    }
}

struct SoundKit {
    
    var theme: Theme
    var soundTrack: String
    var fxSoundHitPaddle: FXSounds
    var fxSoundLose: FXSounds
    var fxSoundRecord: FXSounds
    
    init(theme: Theme) {
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

struct PaddleSkin {
    
    var theme: Theme
    var paddle: String
    
    init(theme: Theme) {
        self.theme = theme
        
        switch theme {
        case .defaultTheme:
            paddle = "PaddleVariation1"
        case .theme2:
            paddle = "PaddleVariation2"
        }
    }
}

struct BackgroundSkin {
    
    var theme: Theme
    var background: String
    
    init(theme: Theme) {
        self.theme = theme
        
        switch theme {
        case .defaultTheme:
            background = "BackgroundVariation1"
        case .theme2:
            background = "BackgroundVariation2"
        }
    }
}
