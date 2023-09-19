//
//  OnboardingView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

enum OnboadingCases {
    case main, watchAgain, notification, gameCenter
}

struct OnboardingView: View {
    
    var onboardingManager = OnboardingManager()
    var hapticsManager: HapticsManagerProtocol = HapticsManager.shared
    var soundManager: SoundManagerProtocol = SoundManager.shared
    
    var onboadingCase: OnboadingCases
    
    @State var viewState = 5
    
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
                case 5:
                    FoneView()
                        .onTapGesture { nextView() }
                case 4:
                    RaqueteView()
                        .onTapGesture { nextView() }
                case 3:
                    PosicaoView()
                        .onTapGesture { nextView() }
                case 2:
                    RebaterView()
                        .onTapGesture { nextView() }
                case 1:
                    PausarView()
                        .onTapGesture { nextView() }
                default:
                    MenuView()
                        .onAppear { onboardingManager.userFinishedOnboarding() }
                }
            }.id(viewState)
                .onAppear {
                    if onboardingManager.onboradingHappend { viewState = 0 }
                }
            
        case .watchAgain:
            Group{
                switch viewState {
                case 5:
                    FoneView()
                        .onTapGesture { nextView() }
                case 4:
                    RaqueteView()
                        .onTapGesture { nextView() }
                case 3:
                    PosicaoView()
                        .onTapGesture { nextView() }
                case 2:
                    RebaterView()
                        .onTapGesture { nextView() }
                default:
                    PausarView()
                        .onTapGesture { presentation.wrappedValue.dismiss() }
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
