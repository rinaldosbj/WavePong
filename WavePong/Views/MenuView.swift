//
//  MenuView.swift
//  WavePong
//
//  Created by rsbj on 04/08/23.
//

import SwiftUI

/// First View, where the user can chose where to go, start a Game, Configuration or Game center.
struct MenuView: View {
    
    @State private var playFistGame = false
    @State private var isShowingGameCenter = false
    let stringsConstants = StringsConstantsModel()
    
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                Image("backgroundGame")
                    .resizable()
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                ScrollView {
                    VStack() {
                        Image("Wave-pong")
                            .accessibilityHidden(true)
                            .padding(.vertical,100)
                        NavigationLink {
                            SelectDifficultyView()
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationBarBackButtonHidden()
                        } label: {
                            LabelButton(buttonStyle: .start, buttonAction:{})
                        }
                        .foregroundColor(.yellow)
                        .accessibilityLabel(stringsConstants.jogar)
                        .accessibilityHint(stringsConstants.jogar_hint)
                        .padding(.vertical, 48)
                        HStack {
                            NavigationLink(destination: {
                                ConfigurationView()
                                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                        .onEnded({ value in
                                            if value.translation.width > 10 {
                                                NavigationUtil.popToPreviusView()
                                            }
                                        }))
                                    .navigationBarTitleDisplayMode(.inline)                                    .navigationBarBackButtonHidden()
                            }) {
                                IconButton(.settings, buttonType: .link, buttonAction: {})
                            }
                            .foregroundColor(.yellow)
                            .accessibilityLabel(stringsConstants.configuracoes)
                            .accessibilityHint(stringsConstants.configuracoes_hint)
                            .padding(.trailing,48)
                            NavigationLink(destination: {
                                Text(stringsConstants.carregando)
                            }) {
                                IconButton(.gameCenter, buttonType: .action, buttonAction: {isShowingGameCenter.toggle()})
                            }
                            .foregroundColor(.yellow)
                            .accessibilityLabel(stringsConstants.game_center)
                            .accessibilityHint(stringsConstants.game_center_hint)
                        }
                    }
                    .onAppear {
                        if !OnboardingManager().onboradingHappend {
                            playFistGame = true
                            OnboardingManager().userFinishedOnboarding()
                        }
                    }
                }
                .fullScreenCover(isPresented: $playFistGame, content: {
                    GameSceneView(viewModel: SelectDifficultyViewModel().viewModelToBePresented(selectedDifficulty: .easy))
                        .ignoresSafeArea()
                })
                .sheet(isPresented: $isShowingGameCenter) {
                    GameCenterView(isPresented: $isShowingGameCenter).ignoresSafeArea()
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
