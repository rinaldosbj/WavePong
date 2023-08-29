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
    @State var togleIsLinear : Bool = false
    @State var togleIsCurved : Bool = true
    var player: PlayerProtocol = Player()
    
    var body: some View {
        //MARK: Main View Build
        ZStack {
            Image("backgroundGame")
                .resizable()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            VStack(spacing: 32) {
                Image("Ajustes")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 268 ,height: 53)
                    .accessibilityHidden(true)
                    .padding(.bottom, 32)
                
                soundModeConfigView
                
                Spacer().frame(height: 24)
                
                backToOnboardingButton
                
            }.padding(.horizontal, 60)
            
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
        if player.soundMode  == .linear {
            togleIsLinear = true
        }
        else {
            togleIsLinear = false
        }
    }
    
    
    func updateToggle(from mode: SoundMode){
        switch mode {
            
        case .linear:
            if togleIsLinear {
                togleIsCurved = false
                player.changeSoundMode(.linear)
            }
            else if !togleIsCurved {
                togleIsLinear = true
            }
            
        case .curved:
            if togleIsCurved{
                togleIsLinear = false
                player.changeSoundMode(.curved)
            }
            else if !togleIsLinear {
                togleIsCurved = true
            }
        }
        
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView()
    }
}
