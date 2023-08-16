//
//  GameSceneView.swift
//  WavePong
//
//  Created by Lucas Migge on 08/08/23.
//

import SwiftUI
import SpriteKit


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
            switch viewModel.state {
            case .game:
                gameView
                    .onAppear(){
                        viewModel.size = geo.size
                        
                    }
                    .onDisappear {
                        gameScene.viewWillDisappear()
                    }
                
                
                
            case .pause:
                pauseView
                
            }
            
        }
    }
    
    private var gameView: some View {
        SpriteView(scene: self.gameScene)
            .ignoresSafeArea()
        
    }
    
    private var pauseView: some View {
        ZStack {
            Image("backgroundGame")
            
            VStack(spacing: 48) {
                Image("PauseLabel")
                
                
                LabelButton(buttonStyle: .resume) {
                    viewModel.continueButtonPressed()
                }
                
                HStack(spacing: 48)  {
                    IconButton(buttonStyle: .home) {
                        
                    }
                    
                    IconButton(buttonStyle: .refresh) {
                        
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
}




struct GameSceneView_Previews: PreviewProvider {
    static var previews: some View {
        GameSceneView()
    }
}
