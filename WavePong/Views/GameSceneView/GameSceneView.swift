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
    
    @Environment(\.scenePhase) private var scenePhase
    
    @ObservedObject var viewModel: GameSceneViewModel
    
    @State var allowInteraction = true
    
    let stringsConstants = StringsConstantsModel()
    
    var gameScene: GameScene {
        let scene = GameScene(size: viewModel.size,
                              gameManager: viewModel.gameManager)
        scene.scaleMode = .fill
        
        return scene
    }
    
    var acessbility: Bool {
        if viewModel.state == .game {
            return true
        } else {
            return false
        }
    }
    
    
    var body: some View {
        GeometryReader{ geo in
            
            ZStack {
                gameView
                    .ignoresSafeArea()
                    .accessibilityElement()
                    .accessibilityRespondsToUserInteraction()
                    .modifier(AddAccessibilityDirectInteractionTrait(condition: acessbility))
                    .onAppear(){
                        viewModel.size = geo.size
                    }
                    .onTapGesture(count: 2) {
                        viewModel.pauseTap()
                    }
                    .overlay {
                        if viewModel.state == .gameOver {
                            gameOverView
                        } else if viewModel.state == .pause {
                            pauseView
                        }
                        
                        
                    }
                
            }
            .onChange(of: scenePhase) { newScenePhase in
                switch newScenePhase {
                case .background:
                    viewModel.appWillMoveToBackground()
                default:
                    print("")
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
            .accessibilityHidden(true)
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
                        .accessibilityHidden(true)
                    
                    if viewModel.userScore == "1" {
                        Text(viewModel.recordLabel)
                            .font(Font.wavePongPrimary(.body))
                            .foregroundColor(Color(ColorConstants.shared.YELLOW_300))
                            .accessibilityLabel("\(stringsConstants.recorde) \(viewModel.recordLabel) \(stringsConstants.ponto)")
                    }
                    else {
                        Text(viewModel.recordLabel)
                            .font(Font.wavePongPrimary(.body))
                            .foregroundColor(Color(ColorConstants.shared.YELLOW_300))
                            .accessibilityLabel("\(stringsConstants.recorde) \(viewModel.recordLabel) \(stringsConstants.pontos)")
                    }
                    
                    
                }
                
                VStack(spacing: -16) {
                    
                    if viewModel.userScore == "1" {
                        Text(viewModel.userScore)
                            .font(Font.wavePongSecundary(.scoreNumber))
                            .accessibilityLabel("\(viewModel.userScore) \(stringsConstants.ponto)")
                        Text(stringsConstants.ponto)
                            .font(Font.wavePongPrimary(.body))
                            .accessibilityHidden(true)
                    }
                    else {
                        Text(viewModel.userScore)
                            .font(Font.wavePongSecundary(.scoreNumber))
                            .accessibilityLabel("\(viewModel.userScore) \(stringsConstants.pontos)")
                        Text(stringsConstants.pontos)
                            .font(Font.wavePongPrimary(.body))
                            .accessibilityHidden(true)
                    }
                    
                }
                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                
                HStack {
                    HStack(spacing: 48)  {
                        IconButton(.home) {
                            NavigationUtil.popToRootView()
                            viewModel.homeButtonPressed()
                        }
                        .accessibilityLabel(stringsConstants.home_hint)
                        
                        IconButton(.refresh) {
                            viewModel.refreshPressed()
                        }
                        .accessibilityLabel(stringsConstants.recomecar_hint)
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
                    .scaledToFit()
                    .frame(width: 253, height: 140)
                    .accessibilityHidden(true)
                
                
                LabelButton(buttonStyle: .resume) {
                    viewModel.continueButtonPressed()
                }
                .accessibilityLabel(stringsConstants.continuar)
                
                
                HStack(spacing: 48)  {
                    IconButton(.home) {
                        NavigationUtil.popToRootView()
                        viewModel.homeButtonPressed()
                    }
                    .accessibilityLabel(stringsConstants.home_hint)
                    
                    IconButton(.refresh) {
                        viewModel.refreshPressed()
                    }
                    .accessibilityLabel(stringsConstants.recomecar_hint)
                }
            }
        }
        
    }
    
    
}
