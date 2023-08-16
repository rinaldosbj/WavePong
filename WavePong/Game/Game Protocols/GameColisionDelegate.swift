//
//  GameActionDelegate.swift
//  WavePong
//
//  Created by Lucas Migge on 14/08/23.
//

import Foundation

/// Protocols for informing gameLogic for colision Event
protocol GameColisionDelegate {
    func incrementScore()
    
    func didLose()
    
}
