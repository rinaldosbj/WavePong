//
//  GameSceneView.swift
//  WavePong
//
//  Created by Lucas Migge on 08/08/23.
//

import SwiftUI
import SpriteKit


struct GameSceneView: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var viewModel: GameSceneViewModel = GameSceneViewModel()
    
    @State var refreshCountPressed: Int = 0
    
    var gameScene: GameScene {
        let scene = GameScene(size: viewModel.size, gameManager: viewModel.gameManager)
        scene.scaleMode = .aspectFit
        
        return scene
    }
        
    
    var body: some View {
        GeometryReader{ geo in
            if refreshCountPressed % 2 == 0 {
                gameView
                    .ignoresSafeArea()
                    .accessibilityRespondsToUserInteraction()
                    .accessibilityElement()
                    .accessibilityAddTraits(.allowsDirectInteraction)
                    .onAppear(){
                        viewModel.size = geo.size
                        viewModel.didGameViewApper()
                        
                    }
                    .onDisappear {
                        gameScene.viewWillDisappear()
                    }
                    .overlay {
                        if viewModel.state == .pause {
                            pauseView

                        }
                    }
            }
            else {
                gameView
                    .ignoresSafeArea()
                    .accessibilityRespondsToUserInteraction()
                    .accessibilityElement()
                    .accessibilityAddTraits(.allowsDirectInteraction)
                    .onAppear(){
                        viewModel.size = geo.size
                        viewModel.didGameViewApper()
                        
                    }
                    .onDisappear {
                        gameScene.viewWillDisappear()
                    }
                    .overlay {
                        if viewModel.state == .pause {
                            pauseView

                        }
                    }
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
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 48) {
                
                Image("PauseLabel")
                    .resizable()
                    .frame(width: 253, height: 71)
                
                
                LabelButton(buttonStyle: .resume) {
                    viewModel.continueButtonPressed()
                }

                
                HStack(spacing: 48)  {
                    IconButton(.home) {
                        presentation.wrappedValue.dismiss()
                    }
                    
                    IconButton(.refresh) {
                        viewModel.refreshPressed()
                        refreshCountPressed += 1
                    }
                }
            }
        }
       
    }
    
}




struct GameSceneView_Previews: PreviewProvider {
    static var previews: some View {
        GameSceneView()
    }
}
