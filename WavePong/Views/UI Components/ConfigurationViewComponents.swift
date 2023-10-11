//
//  ConfigurationViewComponents.swift
//  WavePong
//
//  Created by rsbj on 28/08/23.
//

import SwiftUI

extension ConfigurationView {
    // MARK: View components
    
    var relatedToPaddleTogle: some View {
        HStack {
            VStack {
                ZStack {
                    Image("toggleRectangle")
                        .frame(width: 24, height: 24, alignment: .center)
                        .accessibilityHidden(true)
                    
                    if toglePaddle {
                        Text("X")
                            .foregroundColor(Color(ColorConstants.shared.PURPLE_500))
                            .font(Font.wavePongPrimary(.body))
                            .accessibilityHidden(true)
                            .frame(width: 24, height: 24, alignment: .center)
                    }
                }.padding(.top, 5)
                Spacer()
            }
            
            Text(stringsConstants.som_relacionado)
                .accessibilityLabel(toglePaddle ? "\(stringsConstants.som_relacionado) \(stringsConstants.selecionado)" : "\(stringsConstants.som_relacionado) \(stringsConstants.nao_selecionado)")
                .font(Font.wavePongPrimary(.body))
                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
            
            
            Spacer()
        }.onTapGesture {
            player.togleIsSoundRelatedtoPaddle()
            toglePaddle.toggle()
        }
    }
    
    var backToOnboardingButton: some View {
        NavigationLink {
            OnboardingView(for: .main)
                .navigationBarBackButtonHidden()
        } label: {
            Text(stringsConstants.tutorial)
                .font(Font.wavePongPrimary(.body))
                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                .underline(color:Color(ColorConstants.shared.YELLOW_600))
        }
        
    }
    
    var soundPreview: some View {
        NavigationLink {
            OnboardingSceneView(demoCase: .game, didColide: $didColide, isPause: false)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            SoundManager.shared.stopGameTheme()
                            NavigationUtil.popToPreviusView()
                        } label: {
                            Text(stringsConstants.volta)
                                .font(Font.wavePongPrimary(.body))
                                .layoutPriority(.greatestFiniteMagnitude)
                                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                        }
                    }
                }
                .navigationBarBackButtonHidden()
        } label: {
            Text(stringsConstants.sound_preview)
                .font(Font.wavePongPrimary(.body))
                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                .underline(color:Color(ColorConstants.shared.YELLOW_600))
        }
    }
    
    var soundModeConfigView: some View {
        VStack {
            Text(stringsConstants.modo_som)
                .accessibilityHint(stringsConstants.modo_hint)
                .font(Font.wavePongPrimary(.body))
                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
            
            ForEach(SoundMode.allCases, id: \.self) { type in
                HStack {
                    ZStack {
                        Image("toggleRectangle")
                            .frame(width: 24, height: 24, alignment: .center)
                            .accessibilityHidden(true)
                        
                        if selectedMode == type {
                            Text("X")
                                .foregroundColor(Color(ColorConstants.shared.PURPLE_500))
                                .accessibilityHidden(true)
                                .font(Font.wavePongPrimary(.body))
                                .frame(width: 24, height: 24, alignment: .center)
                        }
                    }
                    
                    switch type {
                    case .linear:
                        Text(stringsConstants.linear)
                            .accessibilityLabel(selectedMode == .linear ? "\(stringsConstants.linear) \(stringsConstants.selecionado)" : "\(stringsConstants.linear) \(stringsConstants.nao_selecionado)")
                            .font(Font.wavePongPrimary(.body))
                            .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    case .highContrast:
                        Text(stringsConstants.alto)
                            .accessibilityLabel(selectedMode == .highContrast ? "\(stringsConstants.alto) \(stringsConstants.selecionado)" : "\(stringsConstants.alto) \(stringsConstants.nao_selecionado)")
                            .font(Font.wavePongPrimary(.body))
                            .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    }
                    
                    Spacer()
                }
                .onTapGesture {
                    player.changeSoundMode(type)
                    selectedMode = player.soundMode
                }
            }
            
        }
    }
    
    var backButton: some View {
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
