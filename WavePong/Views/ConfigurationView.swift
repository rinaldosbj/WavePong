//
//  ConfigurationView.swift
//  WavePong
//
//  Created by rsbj on 05/08/23.
//

import SwiftUI

/// View for changing game settings such as audio orientation and reatch onboarding
struct ConfigurationView: View {
    
    @State var didColide = false
    @Environment(\.presentationMode) var presentation
    @State var selectedMode: SoundMode = .linear
    @State var toglePaddle = false
    @State var togleNotifications = true
    var player: PlayerProtocol = Player()
    
    let stringsConstants = StringsConstantsModel()
    
    var body: some View {
        //MARK: Main View Build
        ZStack {
            Image("backgroundGame")
                .resizable()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            ScrollView {
                VStack(spacing: 20) {
                    Image(stringsConstants.ajustes)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 268 ,height: 53)
                        .accessibilityHidden(true)
                        .padding(.vertical, 40)
                        .padding(.top, 32)
                    
                    soundModeConfigView
                    
                    relatedToPaddleTogle
                    
                    soundPreview
                        .padding(24)
                    backToOnboardingButton
                        .padding(.bottom,24)
                    
                    LabelButton(buttonStyle: .save, buttonAction: {
                        presentation.wrappedValue.dismiss()
                    })
                    
                    
                    // TODO: Find somewhere to put these
                    Spacer().frame(height: 1000)
                    
                    AdsView()
                        .padding(.bottom, 50)
                    
                }.padding(.horizontal, 60)
            }
            
            .onAppear {
                checksCurrentSoundMode()
            }
        }
    }
}


extension ConfigurationView {
    // MARK: RelationShip Functions
    func checksCurrentSoundMode(){
        selectedMode = player.soundMode
        toglePaddle = player.isSoundRelatedtoPaddle
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView()
    }
}
