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
    var impactFeedbackFactory: ImpactFeedbackGeneratorFactoryProtocol!

    
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
        
        XCTAssertTrue(seletectionFeedback.isReady)
        
    }
    
    
}
