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
        let scene = GameScene(size: viewModel.size,
                              gameManager: viewModel.gameManager)
        scene.scaleMode = .fill
        
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
                        
                    }
                
                    .overlay {
                        if viewModel.state == .pause {
                            pauseView
                        } else if viewModel.state == .gameOver {
                            gameOverView
                        }
                    }                    }
            else {
                gameView
                    .ignoresSafeArea()
                    .accessibilityRespondsToUserInteraction()
                    .accessibilityElement()
                    .accessibilityAddTraits(.allowsDirectInteraction)
                    .onAppear(){
                        viewModel.size = geo.size
                        
                    }
                
                    .overlay {
                        if viewModel.state == .pause {
                            pauseView
                        } else if viewModel.state == .gameOver {
                            gameOverView
                        }
                    }
            }
            
        }
    }
    
    private var gameView: some View {
        SpriteView(scene: self.gameScene)
            .ignoresSafeArea()
        
    }
    
    private var backgroundImageView: some View {
        Image("backgroundGame")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    private var gameOverView: some View {
        ZStack {
            backgroundImageView
            
            VStack(spacing: 48) {
                VStack(spacing: 16) {
                    Image("Game-over")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 208, height: 133)
                    
                    Text(viewModel.recordLabel)
                        .font(Font.wavePongPrimary(.body))
                        .foregroundColor(Color(ColorConstants.AMARELO))
                    
                    
                }
                
                VStack(spacing: -16) {
                    Text(viewModel.userScore)
                        .font(Font.wavePongSecundary(.scoreNumber))
                    
                    Text("Pontos")
                        .font(Font.wavePongPrimary(.body))
                    
                }
                
                .foregroundColor(Color(ColorConstants.WHITE))
                
                HStack {
                    HStack(spacing: 48)  {
                        IconButton(.home) {
                            viewModel.homeButtonPressed()
                            presentation.wrappedValue.dismiss()
                        }
                        
                        IconButton(.refresh) {
                            SoundManager.shared.playGameTheme()
                            viewModel.refreshPressed()
                            refreshCountPressed += 1
                        }
                    }
                    
                }
            }
        }
    }
    
    private var pauseView: some View {
        ZStack {
            backgroundImageView
            
            VStack(spacing: 48) {
                
                Image("PauseLabel")
                    .resizable()
                    .frame(width: 253, height: 71)
                
                
                LabelButton(buttonStyle: .resume) {
                    viewModel.continueButtonPressed()
                }
                
                
                HStack(spacing: 48)  {
                    IconButton(.home) {
                        viewModel.homeButtonPressed()
                        presentation.wrappedValue.dismiss()
                    }
                    
                    IconButton(.refresh) {
                        SoundManager.shared.playGameTheme()
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
