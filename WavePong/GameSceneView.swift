//
//  GameSceneView.swift
//  WavePong
//
//  Created by Lucas Migge on 08/08/23.
//

import SwiftUI
import SpriteKit


class GameSceneViewModel: ObservableObject, PauseNodeDelegate {
    
    @Published var size: CGSize = CGSize()
    @Published var state: ViewMode = .game
    
    var gameManager: GameManager
    
    var pauseButtonDelegate: PauseNodeDelegate?
    
    init(gameManager: GameManager = GameManager()) {
        
        self.gameManager = gameManager
        self.gameManager.pauseButtonDelegate = self
    }
    
    enum ViewMode {
        case game, pause
    }
    
    
    func pauseButtonPressed() {
        state = .pause
        print("oioio")
        
    }
    
    
}

struct GameSceneView: View {
    
    @ObservedObject var viewModel = GameSceneViewModel()
    
    
    private var gameScene: GameScene {
        let scene = GameScene(size: viewModel.size, gameManager: viewModel.gameManager)
        scene.size = viewModel.size
        scene.scaleMode = .aspectFit
        return scene
    }
    
    var body: some View {
        GeometryReader{ geo in
            SpriteView(scene: self.gameScene)
                .ignoresSafeArea()
                .onAppear(){
                    viewModel.size = geo.size
                    
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
