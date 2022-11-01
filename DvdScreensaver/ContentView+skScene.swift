//
//  ContentView+skScene.swift
//  DvdScreensaver
//
//  Created by rsbj on 01/11/22.
//

import SwiftUI
import SpriteKit
import AVFoundation

extension ContentView {
    var skScene: SKScene{ // SKScene lembra muito uma view
        let viewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let ballNode = SKSpriteNode(imageNamed: "neonBall") // Node = Objetos
        ballNode.size = CGSize(width: 60, height: 60)
        
        let raqueteNode = SKSpriteNode(imageNamed: "raquete")
        raqueteNode.size = CGSize(width: UIScreen.main.bounds.width/2.5, height: 36)
        
        let nuvemNode = SKSpriteNode(imageNamed: "wave")
        nuvemNode.size = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
        
        let nuvemNode2 = SKSpriteNode(imageNamed: "wave2")
        nuvemNode.size = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
        
        let nuvemNode3 = SKSpriteNode(imageNamed: "wave3")
        nuvemNode.size = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
        
        let scene = PongScene(ballNode: ballNode, size: viewFrame.size, raquete: raqueteNode, nuvem: nuvemNode, nuvem2: nuvemNode2, nuvem3: nuvemNode3, score: $score, deveMostrar: $shouldShowPopUp, pausou: $gamePaused)
        scene.backgroundColor = .darkGray
        
        return scene
    }
}

