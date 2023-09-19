//
//  AdsTests.swift
//  PongTests
//
//  Created by rsbj on 16/09/23.
//

@testable import Pong
import XCTest

final class AdsTests: XCTestCase {
    
    var rewardedAD : RewardedAd!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        rewardedAD = RewardedAd()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAdIsLoadingAndRewarding() {
        var diamonts = 0
        let initialDiamonts = diamonts
        rewardedAD.loadAndShow(rewardFunction: {
            diamonts += 1
            
            XCTAssertNotEqual(initialDiamonts, diamonts)
        })
    }
    
    func testAdPush() {
        rewardedAD.load()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            
            let didShowAdd = self.rewardedAD.showAd(rewardFunction: {})
            
            XCTAssertTrue(didShowAdd)
        })
    }
    
}
