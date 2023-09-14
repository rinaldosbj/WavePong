//
//  ConfigurationView.swift
//  WavePong
//
//  Created by rsbj on 05/08/23.
//

import SwiftUI

struct ConfigurationView: View {
    
    @Environment(\.presentationMode) var presentation
    @State var togleNotifications : Bool = false
    @State var togleIsLinear : Bool = true
    @State var togleIsCurved : Bool = false
    @State var togleIsHighContrast: Bool = false
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
                VStack(spacing: 32) {
                    Image(stringsConstants.ajustes)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 268 ,height: 53)
                        .accessibilityHidden(true)
                        .padding(.vertical, 58)
                    
                    soundModeConfigView
                    
                    Spacer().frame(height: 24)
                    
                    backToOnboardingButton
                    
                    NavigationLink("BallType", destination: SelectBallView())
                        .foregroundColor(.white)
                        .padding()
                        .background(Capsule().fill(Color.purple))
                    
                    AdsView()
                    
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
        switch player.soundMode {
        case .linear:
            togleIsLinear = true
        case .curved:
            togleIsCurved = true
        case .highContrast:
            togleIsHighContrast = true
        }
    }
    
    
    func updateToggle(from mode: SoundMode){
        switch mode {
            
        case .linear:
            if togleIsLinear {
                togleIsCurved = false
                togleIsHighContrast = false
                player.changeSoundMode(.linear)
            }
            else if !togleIsCurved && !togleIsHighContrast {
                togleIsLinear = true
            }
            
        case .curved:
            if togleIsCurved{
                togleIsLinear = false
                togleIsHighContrast = false
                player.changeSoundMode(.curved)
            }
            else if !togleIsLinear && !togleIsHighContrast {
                togleIsCurved = true
            }
        case .highContrast:
            if togleIsHighContrast{
                togleIsCurved = false
                togleIsLinear = false
                player.changeSoundMode(.highContrast)
            }
            else if !togleIsLinear && !togleIsCurved {
                togleIsHighContrast = true
            }
        }
        
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView()
    }
}
