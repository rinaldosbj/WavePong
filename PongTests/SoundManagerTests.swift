//
//  SoundManagerTests.swift
//  PongTests
//
//  Created by Lucas Migge on 14/09/23.
//

import AVFoundation
import XCTest
@testable import Pong

class SoundManagerTests: XCTestCase {
    
    var playerMock: PlayerMock!
    var avAudioplayerFactory: AVAudioplayerFactoryMock!
    var soundManager: SoundManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        playerMock = PlayerMock()
        avAudioplayerFactory = AVAudioplayerFactoryMock()
        soundManager = SoundManager(player: playerMock, aVAudioPlayerFactory: avAudioplayerFactory)
       
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPlayFXSoundIsNotNil() {
        
        soundManager.playFXSound(for: .alert)
        
        
        XCTAssertNotNil(soundManager.audioPLayer)
        
    }
    
    func testPlayFXSoundIsPlayingOnAudioPlayer() {
        
        soundManager.playFXSound(for: .alert)
        
        guard let safeAudioPlayer = soundManager.audioPLayer as? AVAudioPlayerMock else { return }
        
        XCTAssertTrue(safeAudioPlayer.isPlaying)
        
    }
    

    func testMusicPlayerNotNilWhemPlayingMusic() {
        soundManager.playGameTheme()
        
        XCTAssertNotNil(soundManager.musicPlayer)
    }
    
    func testPlayGameTheme() {
        
        soundManager.playGameTheme()
        
        guard let safeMusicPlayer = soundManager.musicPlayer as? AVAudioPlayerMock else { return }
        
        XCTAssertTrue(safeMusicPlayer.isPlaying)
 
    }
    
    func testPauseGameTheme() {
        
        soundManager.playGameTheme()
        
        soundManager.pauseGameTheme()
        
        guard let safeMusicPlayer = soundManager.musicPlayer as? AVAudioPlayerMock else { return }
        
        XCTAssertFalse(safeMusicPlayer.isPlaying)
        
    }
    
    func testStopGameTheme() {
        soundManager.playGameTheme()
        
        soundManager.stopGameTheme()
        
        guard let safeMusicPlayer = soundManager.musicPlayer as? AVAudioPlayerMock else { return }
        
        XCTAssertFalse(safeMusicPlayer.isPlaying)
    }
    
    
    func testResumeMusic() {
        soundManager.playGameTheme()
        
        soundManager.pauseGameTheme()
        soundManager.resumeGameTheme()
        
        XCTAssertNotNil(soundManager.musicPlayer)
        
        guard let safeMusicPlayer = soundManager.musicPlayer as? AVAudioPlayerMock else { return }
        
        XCTAssertTrue(safeMusicPlayer.isPlaying)
        
    }
    
    
    func testUpdateAudioOrientationChangesVolume() {
        let paddlePosition = CGPoint()
        let ballPosition = CGPoint(x: 50, y: 50)
        let frameSize = CGSize(width: 100, height: 100)
        let initialVolume: Float = 1
        
        let info = AudioOrientationInfo(paddlePosition: paddlePosition, ballPosition: ballPosition, size: frameSize)
        
        soundManager.playGameTheme()
        soundManager.musicPlayer?.volume = initialVolume

        
        soundManager.updateAudioOrientation(info)
        
        
        
        XCTAssertNotEqual(initialVolume, soundManager.musicPlayer?.volume)
        
    }
    
    
    func testUpdateAudioOrientationChangesPan() {
        
        let paddlePosition = CGPoint()
        let ballPosition = CGPoint(x: 50, y: 50)
        let frameSize = CGSize(width: 100, height: 100)
        let initialPan: Float = 0
        
        soundManager.playGameTheme()
        soundManager.musicPlayer?.pan = initialPan
        
        let info = AudioOrientationInfo(paddlePosition: paddlePosition, ballPosition: ballPosition, size: frameSize)
        soundManager.updateAudioOrientation(info)
        
        XCTAssertNotEqual(initialPan, soundManager.musicPlayer?.pan)
        
    }
    
    
    func testUpdateAudioOrientationChangesPanConsrastModeDoNotChangeCenter() {
        playerMock.soundMode = .highContrast
        let paddlePosition = CGPoint()
        let ballPosition = CGPoint(x: 34, y: 50)
        let frameSize = CGSize(width: 100, height: 100)
        let initialPan: Float = 0
        
        
        soundManager.playGameTheme()
        soundManager.musicPlayer?.pan = initialPan
        
        let info = AudioOrientationInfo(paddlePosition: paddlePosition, ballPosition: ballPosition, size: frameSize)
        soundManager.updateAudioOrientation(info)
        
        XCTAssertEqual(initialPan, soundManager.musicPlayer?.pan)
        
    }
    
    func testUpdateAudioOrientationChangesPanConsrastModeChangesLeft() {
        playerMock.soundMode = .highContrast
        let paddlePosition = CGPoint()
        let ballPosition = CGPoint(x: 32, y: 50)
        let frameSize = CGSize(width: 100, height: 100)
        let initialPan: Float = 0
        
        
        soundManager.playGameTheme()
        soundManager.musicPlayer?.pan = initialPan
        
        let info = AudioOrientationInfo(paddlePosition: paddlePosition, ballPosition: ballPosition, size: frameSize)
        soundManager.updateAudioOrientation(info)
        
        XCTAssertEqual(-1, soundManager.musicPlayer?.pan)
        
    }
    
    func testUpdateAudioOrientationChangesPanConsrastModeChangesRight() {
        playerMock.soundMode = .highContrast
        let paddlePosition = CGPoint()
        let ballPosition = CGPoint(x:67, y: 50)
        let frameSize = CGSize(width: 100, height: 100)
        let initialPan: Float = 0
        
        
        soundManager.playGameTheme()
        soundManager.musicPlayer?.pan = initialPan
        
        
        let info = AudioOrientationInfo(paddlePosition: paddlePosition, ballPosition: ballPosition, size: frameSize)
        soundManager.updateAudioOrientation(info)
        
        XCTAssertEqual(1, soundManager.musicPlayer?.pan)
        
    }
    
}
