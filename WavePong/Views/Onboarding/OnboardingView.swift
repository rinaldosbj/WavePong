//
//  OnboardingView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct OnboardingView: View {
    
    var player: Player = Player.shared
    var hapticsManager: HapticsManager = HapticsManager.shared
    var soundManager: SoundManager = SoundManager.shared
    
    @State var viewState = 5
    
    @Environment(\.presentationMode) var presentation
    
    private func nextView() {
        viewState -= 1
        hapticsManager.vibrateNotification(for: .success)
//        soundManager.playFXSound(for: .pickupCoin)
    }
    
    var body: some View {
        Group{
            switch viewState {
            case 5:
                FoneView()
                    .onTapGesture {
                        nextView()
                    }
                
            case 4:
                RaqueteView()
                    .onTapGesture { nextView() }
            case 3:
                PosicaoView()
                    .onTapGesture { nextView() }
            case 2:
                RebaterView()
                    .onTapGesture {
                        if player.onboradingHappend {
                            presentation.wrappedValue.dismiss()
                        }
                        else {
                            nextView()
                        }
                    }
//            case 1:
//                PausarView()
//                    .onTapGesture {
//                        if player.onboradingHappend {
//                            presentation.wrappedValue.dismiss()
//                        }
//                        else {
//                            nextView()
//                        }
//                    }
            default:
                MenuView()
                    .onAppear {
                        player.userFinishedOnboarding()
                    }
            }
        }.id(viewState)
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
