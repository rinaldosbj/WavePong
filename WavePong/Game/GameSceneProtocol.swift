//
//  GameSceneProtocol.swift
//  WavePong
//
//  Created by Lucas Migge on 05/08/23.
//

import Foundation

protocol GameSceneProtocol {
    func didUserScored(newScore score: Int)
    
    func gameOver()
    
    func pausePressed()
    
}
