//
//  OnboardingTests.swift
//  PongTests
//
//  Created by rsbj on 19/09/23.
//
@testable import Pong
import XCTest

final class OnboardingTests: XCTestCase {
    
    var onboading: OnboardingProtocol!
    var userDefaultsMock: UserDefaultsMock!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userDefaultsMock = UserDefaultsMock()
        onboading = OnboardingManager(defaults: userDefaultsMock)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShouldshowOnboardingOnFirstLaunch() {
        XCTAssertFalse(onboading.onboradingHappend)
    }
    
    func testShouldNotShowOnboardingAfterFirstLaunch() {
        // given
        onboading.userFinishedOnboarding()
        
        // when
        onboading = OnboardingManager(defaults: userDefaultsMock)
        
        // then
        XCTAssertTrue(onboading.onboradingHappend)
    }
}
