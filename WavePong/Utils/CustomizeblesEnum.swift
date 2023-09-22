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
    case defaultTheme, variation1
}


struct SoundKit {
    var soundTrack: String
    var fxSoundHitPaddle: FXSounds
    var fxSoundLose: FXSounds
    var fxSoundRecord: FXSounds
    
}

struct CloudSkins {
    var cloud1: String
    var cloud2: String
    var cloud3: String
    
}


protocol ThemeSkin {
    var backgroundSkin: String { get }
    var ballSkin: String { get }
    var paddleSkin: String { get }
    var cloudsSkins: CloudSkins { get }
}

protocol ThemeSound {
    
    var soundKit: SoundKit { get }
}

struct Theme: ThemeSkin, ThemeSound {
    var backgroundSkin: String
    
    var ballSkin: String
    
    var paddleSkin: String
    
    var cloudsSkins: CloudSkins
    
    var soundKit: SoundKit
    
    init(backgroundSkin: String = "backgroundGame", ballSkin: String = "ball_yellow", paddleSkin: String = "raquete", cloudsSkins: CloudSkins = CloudSkins(cloud1: "wave1", cloud2: "wave2", cloud3: "wave3") , soundKit: SoundKit = SoundKit(soundTrack: "", fxSoundHitPaddle: .alert, fxSoundLose: .alert, fxSoundRecord: .alert)) {
        self.backgroundSkin = backgroundSkin
        self.ballSkin = ballSkin
        self.paddleSkin = paddleSkin
        self.cloudsSkins = cloudsSkins
        self.soundKit = soundKit
    }
    
}


class ThemeFactory {
    
    let constants: ImageConstants
    
    init(constants: ImageConstants = ImageConstants.shared) {
        self.constants = constants
    }
    
    func createTheme(theme: ThemeStyle) -> Theme {
        switch theme {
            
        case .variation1:
            let clouds = CloudSkins(
                cloud1: constants.DEFAULTWAVE1,
                cloud2: constants.DEFAULTWAVE2,
                cloud3: constants.DEFAULTWAVE3)
            
            let soundKit = SoundKit(soundTrack: "WavePong_soundtrack ", fxSoundHitPaddle: .hehe, fxSoundLose: .bonus, fxSoundRecord: .cuteClick)
            
            return Theme(backgroundSkin: constants.DEFAULTBACKGROUND, ballSkin: constants.DEFAULTBALL, paddleSkin: constants.DEFAULTPADDLE, cloudsSkins: clouds, soundKit: soundKit)

            
            
        default:
            let clouds = CloudSkins(
                cloud1: constants.DEFAULTWAVE1,
                cloud2: constants.DEFAULTWAVE2,
                cloud3: constants.DEFAULTWAVE3)
            
            let soundKit = SoundKit(soundTrack: "WavePong_soundtrack ", fxSoundHitPaddle: .hehe, fxSoundLose: .bonus, fxSoundRecord: .cuteClick)
            
            return Theme(backgroundSkin: constants.DEFAULTBACKGROUND, ballSkin: constants.DEFAULTBALL, paddleSkin: constants.DEFAULTPADDLE, cloudsSkins: clouds, soundKit: soundKit)
        }
    }
}


