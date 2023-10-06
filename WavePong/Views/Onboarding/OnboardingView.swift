//
//  OnboardingView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

enum OnboadingCases {
    case main, notification, gameCenter
}

struct OnboardingView: View {
    
    let stringsConstants = StringsConstantsModel()
    
    var onboardingManager = OnboardingManager()
    var hapticsManager: HapticsManagerProtocol = HapticsManager.shared
    var soundManager: SoundManagerProtocol = SoundManager.shared
    
    var onboadingCase: OnboadingCases
    
    @State var viewState = 6
    
    @State var didColide = false
    
    @Environment(\.presentationMode) private var presentation
    
    init(for onboadingCase: OnboadingCases) {
        self.onboadingCase = onboadingCase
    }
    
    private func nextView() {
        viewState -= 1
        hapticsManager.vibrateNotification(for: .success)
    }
    
    var body: some View {
        switch onboadingCase {
        case .main:
            Group{
                switch viewState {
                case 6:
                    FoneView()
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .accessibilityLabel("\(stringsConstants.tutorial_onboarding)..\(stringsConstants.coloque_fone)")
                        .accessibilityHint(stringsConstants.onboading_hint)
                        .onTapGesture { nextView() }
                case 5:
                    VolumeView()
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .accessibilityLabel(stringsConstants.volume_onboarding)
                        .onTapGesture {
                            nextView()
                            soundManager.stopGameTheme()
                        }
                case 4:
                    PosicaoView()
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .accessibilityLabel(stringsConstants.bola_guiada)
                        .accessibilityHint(stringsConstants.onboading_hint)
                        .onTapGesture {
                            nextView()
                            soundManager.stopGameTheme()
                        }
                case 3:
                    RaqueteView()
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .accessibilityLabel(stringsConstants.mover_raquete)
                        .accessibilityHint(stringsConstants.onboading_hint)
                        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded({ value in
                                if value.translation.width < -10 || value.translation.width > 10 {
                                    soundManager.stopGameTheme()
                                    nextView()
                                }
                            }))
                case 2:
                    RebaterView(didColide: $didColide)
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .accessibilityLabel(stringsConstants.raquete_bola)
                        .accessibilityHint(stringsConstants.onboarding_hint_raquete)
                        .onChange(of: didColide, perform: { newValue in
                            nextView()
                            soundManager.stopGameTheme()
                        })
                case 1:
                    PausarView()
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .accessibilityLabel(stringsConstants.dois_toques)
                        .accessibilityHint(stringsConstants.onboarding_hint_pause)
                        .onTapGesture(count: 2, perform: {
                            soundManager.stopGameTheme()
                            if onboardingManager.onboradingHappend {
                                presentation.wrappedValue.dismiss()
                            }
                            else { nextView() }
                        })
                default:
                    MenuView()
                }
            }.id(viewState)
            
        case .notification:
            Text("Voltar")
                .onTapGesture {
                    presentation.wrappedValue.dismiss()
                }
        case .gameCenter:
            Text("Voltar")
                .onTapGesture {
                    presentation.wrappedValue.dismiss()
                }
        }
    }
    
}
