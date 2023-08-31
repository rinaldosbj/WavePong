//
//  SelectDifficultyView.swift
//  WavePong
//
//  Created by rsbj on 31/08/23.
//

import SwiftUI

struct SelectDifficultyView: View {
    
    @Environment(\.presentationMode) var presentation
    
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
                        .foregroundColor(.white)
                        .accessibilityLabel("Selecione a dificuldade de jogo para começar")
                    Spacer().frame(height: 48)
                    NavigationLink {
                        GameSceneView(viewModel: createViewModel(.easy))
                            .navigationBarBackButtonHidden()
                    } label: {
                        LabelButton(buttonStyle: .easy, buttonAction: {})
                    }
                    Spacer().frame(height: 48)
                    NavigationLink {
                        GameSceneView(viewModel: createViewModel(.medium))
                            .navigationBarBackButtonHidden()
                    } label: {
                        LabelButton(buttonStyle: .medium, buttonAction: {})
                    }
                    Spacer().frame(height: 48)
                    NavigationLink {
                        GameSceneView(viewModel: createViewModel(.hard))
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
                                .foregroundColor(.white)
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
