//
//  AudioRelatableNodes.swift
//  WavePong
//
//  Created by rsbj on 22/09/23.
//

import Foundation

protocol AudioNodesRelatable {
    var paddle: Paddle? { get set }
    var ball: BallSprite? { get set }
    var size: CGSize { get set }
    
}
