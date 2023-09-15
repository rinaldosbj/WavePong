//
//  ImpactFeedbackGeneratorFactory.swift
//  WavePong
//
//  Created by Lucas Migge on 15/09/23.
//

import Foundation
import UIKit


class ImpactFeedbackGeneratorFactory: ImpactFeedbackGeneratorFactoryProtocol {
    func createImpactFeedbackGenerator(withStyle style: UIImpactFeedbackGenerator.FeedbackStyle) -> ImpactFeedbackGeneratable {
        return UIImpactFeedbackGenerator(style: style)
    }
}

protocol ImpactFeedbackGeneratorFactoryProtocol {
    func createImpactFeedbackGenerator(withStyle style: UIImpactFeedbackGenerator.FeedbackStyle) -> ImpactFeedbackGeneratable
}
