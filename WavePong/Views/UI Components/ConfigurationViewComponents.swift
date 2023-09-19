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
    
    var soundModeConfigView: some View {
        VStack {
            HStack {
                Text(stringsConstants.modo_som)
                    .accessibilityHint(stringsConstants.modo_hint)
                    .font(Font.wavePongPrimary(.body))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                Spacer()
            }
            
            HStack {
                Toggle("", isOn: $togleIsLinear)
                    .toggleStyle(SelectCustomToggleStyle(mode: .linear))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .accessibilityLabel(stringsConstants.linear_hint)
                    .onChange(of: togleIsLinear) { _ in
                        updateToggle(from: .linear)
                    }
                Spacer()
            }
            HStack {
                Toggle("",isOn: $togleIsCurved)
                    .toggleStyle(SelectCustomToggleStyle(mode: .curved))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .accessibilityLabel(stringsConstants.exponencial_hint)
                    .onChange(of: togleIsCurved) { _ in
                        updateToggle(from: .curved)
                    }
                Spacer()
            }
            
            HStack {
                Toggle("",isOn: $togleIsHighContrast)
                    .toggleStyle(SelectCustomToggleStyle(mode: .highContrast))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .accessibilityLabel(stringsConstants.alto_hint)
                    .onChange(of: togleIsHighContrast) { _ in
                        updateToggle(from: .highContrast)
                    }
                Spacer()
            }
        }
    }
    
    var notificationToggleView: some View {
        // Unused
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
}
