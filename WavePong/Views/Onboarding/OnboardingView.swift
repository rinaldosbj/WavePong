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
                        .accessibilityLabel(stringsConstants.coloque_fone)
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .onTapGesture { nextView() }
                        
                case 5:
                    RaqueteView()
                        .accessibilityLabel(stringsConstants.raquete_bola)
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .onTapGesture { nextView() }
                case 4:
                    VolumeView()
                        .accessibilityLabel(stringsConstants.volume_onboarding)
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .onTapGesture {
                            nextView()
                            soundManager.stopGameTheme()
                        }
                case 3:
                    PosicaoView()
                        .accessibilityLabel(stringsConstants.bola_guiada)
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .onTapGesture {
                            nextView()
                            soundManager.stopGameTheme()
                        }
                case 2:
                    RebaterView(didColide: $didColide)
                        .accessibilityLabel(stringsConstants.mover_raquete)
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .onChange(of: didColide, perform: { newValue in
                            nextView()
                            soundManager.stopGameTheme()
                        })
                case 1:
                    PausarView()
                        .accessibilityLabel(stringsConstants.dois_toques)
                        .accessibilityElement()
                        .accessibilityRespondsToUserInteraction()
                        .accessibilityAddTraits(.allowsDirectInteraction)
                        .onTapGesture {
                            if onboardingManager.onboradingHappend {
                                presentation.wrappedValue.dismiss()
                            }
                            else { nextView() }
                        }
                default:
                    MenuView()
                        .onAppear { onboardingManager.userFinishedOnboarding() }
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
