//
//  SelectDifficultyView.swift
//  WavePong
//
//  Created by rsbj on 31/08/23.
//

import SwiftUI



struct SelectDifficultyView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @StateObject var viewModel: SelectDifficultyViewModel = SelectDifficultyViewModel()
    
    
    let stringsConstants = StringsConstantsModel()

    
    var body: some View {
        NavigationView {
            ZStack {
                Image("backgroundGame")
                    .resizable()
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                
                VStack {
                    Text(stringsConstants.dificuldade)
                        .font(Font.wavePongPrimary(.headline))
                        .layoutPriority(.greatestFiniteMagnitude)
                        .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                        .accessibilityLabel(stringsConstants.dificuldade_hint)
                    
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
                            Text(stringsConstants.volta)
                                .font(Font.wavePongPrimary(.body))
                                .layoutPriority(.greatestFiniteMagnitude)
                                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                        }
                        .accessibilityLabel(stringsConstants.volta_hint)
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
