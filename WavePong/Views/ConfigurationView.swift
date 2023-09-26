//
//  ConfigurationView.swift
//  WavePong
//
//  Created by rsbj on 05/08/23.
//

import SwiftUI

struct ConfigurationView: View {
    
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
                        .padding(.top, 40)
                    
                    soundModeConfigView
                    
                    Spacer().frame(height: 24)

                    relatedToPaddleTogle
                        .padding(.bottom, 34)
                    
                    
                    backToOnboardingButton
                    
                    
                    // TODO: Find somewhere to put these
                    Spacer().frame(height: 1000)
                    
                    NavigationLink {
                        SelectBallView()
                    } label: {
                        Text("Ball Color")
                            .font(Font.wavePongPrimary(.body))
                            .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                            .underline(color:Color(ColorConstants.shared.YELLOW_600))
                    }
                    
                    AdsView()
                    // TODO: It doesn't belong here
                        .padding(.bottom, 50)
                    
                }.padding(.horizontal, 60)
            }
            
            backButton
            
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
