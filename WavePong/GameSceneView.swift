//
//  GameSceneView.swift
//  WavePong
//
//  Created by Lucas Migge on 08/08/23.
//

import SwiftUI
import SpriteKit


struct GameSceneView: View {
    @State var size = CGSize()
    @State var trigger: Bool = false
    
    var gameScene: GameScene {
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
                .onDisappear {
                    gameScene.viewWillDisappear()
                }
                
        }

    }

}

struct GameSceneView_Previews: PreviewProvider {
    static var previews: some View {
        GameSceneView()
    }
}
