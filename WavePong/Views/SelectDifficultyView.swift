//
//  SelectDifficultyView.swift
//  WavePong
//
//  Created by rsbj on 31/08/23.
//

import SwiftUI

struct SelectDifficultyView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var gameSceneViewModelEasy = GameSceneViewModel(gameManager: GameManager(gameDifficulty: .easy))
    var gameSceneViewModelMedium = GameSceneViewModel(gameManager: GameManager(gameDifficulty: .medium))
    var gameSceneViewModelHard = GameSceneViewModel(gameManager: GameManager(gameDifficulty: .hard))
    
    internal func createViewModel(_ dificulty: GameDifficulty) -> GameSceneViewModel {
        let gameManager = GameManager(gameDifficulty: dificulty)
        return GameSceneViewModel(gameManager: gameManager)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundGame")
                    .resizable()
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                
                VStack {
                    Text("Dificuldade")
                        .font(.custom("DaysOne-Regular", size: 36))
                        .layoutPriority(.greatestFiniteMagnitude)
                        .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                        .accessibilityLabel("Selecione a dificuldade de jogo para começar")
                    Spacer().frame(height: 48)
                    NavigationLink {
                        GameSceneView(viewModel: gameSceneViewModelEasy)
                            .navigationBarBackButtonHidden()
                    } label: {
                        LabelButton(buttonStyle: .easy, buttonAction: {})
                    }
                    Spacer().frame(height: 48)
                    NavigationLink {
                        GameSceneView(viewModel: gameSceneViewModelMedium)
                            .navigationBarBackButtonHidden()
                    } label: {
                        LabelButton(buttonStyle: .medium, buttonAction: {})
                    }
                    Spacer().frame(height: 48)
                    NavigationLink {
                        GameSceneView(viewModel: gameSceneViewModelHard)
                            .navigationBarBackButtonHidden()
                    } label: {
                        LabelButton(buttonStyle: .hard, buttonAction: {})
                    }
                }
                
                HStack {
                    VStack {
                        Button {
                            presentation.wrappedValue.dismiss()
                        } label: {
                            Text("  < Voltar")
                                .font(.custom("DaysOne-Regular", size: 24))
                                .layoutPriority(.greatestFiniteMagnitude)
                                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                        }
                        .accessibilityLabel("Voltar")
                        Spacer()
                    }
                    Spacer()
                }

            }
        }
        .navigationViewStyle(.stack)
    }
}

struct SelectDifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDifficultyView()
    }
}
