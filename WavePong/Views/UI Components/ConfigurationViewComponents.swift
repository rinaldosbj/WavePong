//
//  ConfigurationViewComponents.swift
//  WavePong
//
//  Created by rsbj on 28/08/23.
//

import SwiftUI

extension ConfigurationView {
    
    // MARK: View components
    var backToOnboardingButton: some View {
        
        VStack {
            NavigationLink {
                OnboardingSceneView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Preview SoundMode")
                    .font(Font.wavePongPrimary(.body))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .underline(color:Color(ColorConstants.shared.YELLOW_600))
            }

            
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
        
      
    }
    
    var soundModeConfigView: some View {
        VStack {
            HStack {
                Text(stringsConstants.modo_som)
                    .accessibilityHint(stringsConstants.modo_hint)
                    .font(Font.wavePongPrimary(.body))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                Spacer()
            }
            
            ForEach(SoundMode.allCases, id: \.self) { type in
                HStack {
                    ZStack {
                        Color(ColorConstants.shared.WHITE_500)
                            .frame(width: 24, height: 24, alignment: .center)
                            .border(Color(ColorConstants.shared.PURPLE_500),width: 2)
                        
                        if selectedMode == type {
                            Text("X")
                                .foregroundColor(Color(ColorConstants.shared.PURPLE_500))
                                .font(Font.wavePongPrimary(.body))
                                .frame(width: 24, height: 24, alignment: .center)
                        }
                    }
                    
                    switch type {
                    case .linear:
                        Text(stringsConstants.linear)
                            .font(Font.wavePongPrimary(.body))
                            .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    case .curved:
                        Text(stringsConstants.exponencial)
                            .font(Font.wavePongPrimary(.body))
                            .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    case .highContrast:
                        Text(stringsConstants.alto)
                            .font(Font.wavePongPrimary(.body))
                            .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    case .paddleRelated:
                        Text("PaddleRelated")
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
    
    var notificationToggleView: some View {
        // MARK: This Notification is Unused
        // We can't disable notifications in that way
        HStack {
            Text("Notificações")
                .font(Font.wavePongPrimary(.body))
                .layoutPriority(.greatestFiniteMagnitude)
                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                .accessibilityHidden(true)
            if togleNotifications {
                Toggle("", isOn: $togleNotifications)
                    .toggleStyle(NotificationsCustomToggleStyle(onColor: UIColor(Color(ColorConstants.shared.PURPLE_500)), offColor: .darkGray))
                    .accessibilityLabel(Text("Desativar notificações"))
                
            }
            else {
                Toggle("", isOn: $togleNotifications)
                    .toggleStyle(NotificationsCustomToggleStyle(onColor: UIColor(Color(ColorConstants.shared.PURPLE_500)), offColor: .darkGray))
                    .accessibilityLabel(Text("Ativar notificações"))
            }
        }
    }
}
