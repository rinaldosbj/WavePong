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
            OnboardingView()
                .navigationBarBackButtonHidden()
        } label: {
            Text("Rever Tutorial")
                .font(.custom("DaysOne-Regular", size: 24))
                .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                .underline(color:Color(ColorConstants.shared.YELLOW_600))
        }
        .accessibilityLabel(Text("Rever tutorial"))
    }
    
    var soundModeConfigView: some View {
        VStack {
            HStack {
                Text("Som")
                    .accessibilityHint("Selecione qual modo de som deseja escutar:")
                    .font(.custom("DaysOne-Regular", size: 24))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                Spacer()
            }
            
            HStack {
                Toggle("", isOn: $togleIsLinear)
                    .toggleStyle(SelectCustomToggleStyle(mode: .linear))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .accessibilityLabel("Modo linear")
                    .onChange(of: togleIsLinear) { _ in
                        updateToggle(from: .linear)
                    }
                Spacer()
            }
            HStack {
                Toggle("",isOn: $togleIsCurved)
                    .toggleStyle(SelectCustomToggleStyle(mode: .curved))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .accessibilityLabel("Modo exponencial")
                    .onChange(of: togleIsCurved) { _ in
                        updateToggle(from: .curved)
                    }
                Spacer()
            }
            
            HStack {
                Toggle("",isOn: $togleIsHighContrast)
                    .toggleStyle(SelectCustomToggleStyle(mode: .highContrast))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .accessibilityLabel("Modo alto contraste")
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
                .font(.custom("DaysOne-Regular", size: 24))
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
                    Text("  < Voltar")
                        .font(.custom("DaysOne-Regular", size: 24))
                        .layoutPriority(.greatestFiniteMagnitude)
                        .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                }
                .accessibilityLabel("Voltar")
                Spacer()
            }
            Spacer()
        }
    }
}
