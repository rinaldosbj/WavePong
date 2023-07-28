//
//  ContentView.swift
//  WavePong
//
//  Created by Lucas Migge on 28/07/23.
//

import SwiftUI
import SpriteKit


struct ContentView: View {
    
    var gameScene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 390, height: 844)
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: self.gameScene)
            .ignoresSafeArea()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
