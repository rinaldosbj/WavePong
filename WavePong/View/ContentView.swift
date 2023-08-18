//
//  ContentView.swift
//  WavePong
//
//  Created by Lucas Migge on 28/07/23.
//

import SwiftUI
import SpriteKit


struct ContentView: View {
    
    @State var size = CGSize()
    
    var gameScene: SKScene {
        let scene = GameScene()
        scene.size = size
        scene.scaleMode = .aspectFit
        return scene
    }

    var body: some View {
        GeometryReader{ geo in
            SpriteView(scene: self.gameScene)
                .ignoresSafeArea()
                .onAppear(){
                    size = geo.size
                }
        }

    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
