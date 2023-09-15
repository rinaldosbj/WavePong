//
//  HapticsManagerTests.swift
//  PongTests
//
//  Created by Lucas Migge on 15/09/23.
//

import Foundation
import XCTest
@testable import Pong


class HapticsManagerTests: XCTestCase {
    
    var hapticsManager: HapticsManager!

    var seletectionFeedback: SelectionFeebackGeneretorMock!
    var notificiationFeedback: NotificationFeedbackgeneratorMock!
    var impactFeedbackFactory: ImpactFeedbackGeneratorFactoryMock!

    
    override func setUp() async throws {
        
        seletectionFeedback = SelectionFeebackGeneretorMock()
        notificiationFeedback = NotificationFeedbackgeneratorMock()
        impactFeedbackFactory = ImpactFeedbackGeneratorFactoryMock()
        
        hapticsManager = HapticsManager(selectionFeedback: seletectionFeedback,
                                        notificationFeedback: notificiationFeedback,
                                        impactFeedbackFactory: impactFeedbackFactory)
        
    }
    
    
    func testSelectionFeedback() {

        seletectionFeedback.isReady = false
        seletectionFeedback.didVibrate = false
        
        hapticsManager.vibrate()
        
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.seletectionFeedback.didVibrate)
        }
        
    }
    
    func testNotificiationfeedbackError() {
        
        notificiationFeedback.typeThatVibrated = nil
        
        hapticsManager.vibrateNotification(for: .error)
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.notificiationFeedback.typeThatVibrated, .error)
        }
        
    }
    
    func testNotificiationfeedbackWarming() {
        
        notificiationFeedback.typeThatVibrated = nil
        
        hapticsManager.vibrateNotification(for: .warning)
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.notificiationFeedback.typeThatVibrated, .warning)
        }
        
    }
    
    func testNotificiationfeedbackSuccess() {
        
        notificiationFeedback.typeThatVibrated = nil
        
        hapticsManager.vibrateNotification(for: .success)
        
        DispatchQueue.main.async {
            XCTAssertEqual(self.notificiationFeedback.typeThatVibrated, .success)
        }
        
    }
    
    
    func testImpactFeedback() {
    
        let expectedType: UIImpactFeedbackGenerator.FeedbackStyle = .heavy
        let expectedIntensity: CGFloat = 0.8
        
        hapticsManager.vibrateImpact(for: expectedType, intensity: expectedIntensity)
        
        let impactFeedbackGeneretor = impactFeedbackFactory.impactFeedbackGenerator
        
        XCTAssertEqual(expectedType, impactFeedbackGeneretor?.styleFeedback)
        XCTAssertEqual(expectedIntensity, impactFeedbackGeneretor?.intensityFeedbackOccurred)
        
    }
    
}
