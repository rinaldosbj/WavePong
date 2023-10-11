//
//  SelectDifficultyView.swift
//  WavePong
//
//  Created by rsbj on 31/08/23.
//

import SwiftUI


/// View that is showed before a game start, where the player can choose in what difficulty he wants to play
struct SelectDifficultyView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @StateObject var viewModel: SelectDifficultyViewModel = SelectDifficultyViewModel()

    
    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundGame")
                    .resizable()
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                
                VStack {
                    Text(viewModel.labelDifficulty)
                        .font(Font.wavePongPrimary(.headline))
                        .layoutPriority(.greatestFiniteMagnitude)
                        .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                        .accessibilityLabel(viewModel.labelDifficultyHint)
                    
                    Spacer().frame(height: 48)

                    
                    VStack(spacing: 48) {
                        ForEach(GameDifficulty.allCases, id: \.self) { difficulty in
                            NavigationLink {
                                GameSceneView(viewModel:
                                                viewModel.viewModelToBePresented(selectedDifficulty: difficulty)
                                    
                                )
                                .navigationBarBackButtonHidden()
                            } label: {
                                SelectDifficultyLabel(difficulty: difficulty)
                            }

                        }
                    }
                   
                    
                }
                
                HStack {
                    VStack {
                        Button {
                            presentation.wrappedValue.dismiss()
                        } label: {
                            Text(viewModel.labelReturn)
                                .font(Font.wavePongPrimary(.body))
                                .layoutPriority(.greatestFiniteMagnitude)
                                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                        }
                        .accessibilityLabel(viewModel.labelReturnHint)
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
