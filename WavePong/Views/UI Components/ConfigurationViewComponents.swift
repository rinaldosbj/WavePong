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
                .foregroundColor(.white)
                .underline(color:Color("amarelo"))
        }
        .accessibilityLabel(Text("Rever tutorial"))
    }
    
    var soundModeConfigView: some View {
        VStack {
            HStack {
                Text("Som")
                    .accessibilityHint("Selecione qual modo de som deseja escutar:")
                    .font(.custom("DaysOne-Regular", size: 24))
                    .foregroundColor(.white)
                Spacer()
            }
            
            HStack {
                Toggle("", isOn: $togleIsLinear)
                    .toggleStyle(SelectCustomToggleStyle(mode: .linear))
                    .foregroundColor(.white)
                    .accessibilityLabel("Modo linear")
                    .onChange(of: togleIsLinear) { _ in
                        updateToggle(from: .linear)
                    }
                Spacer()
            }
            HStack {
                Toggle("",isOn: $togleIsCurved)
                    .toggleStyle(SelectCustomToggleStyle(mode: .curved))
                    .foregroundColor(.white)
                    .accessibilityLabel("Modo exponencial")
                    .onChange(of: togleIsCurved) { _ in
                        updateToggle(from: .curved)
                    }
                Spacer()
            }
            
            HStack {
                Toggle("",isOn: $togleIsHighContrast)
                    .toggleStyle(SelectCustomToggleStyle(mode: .highContrast))
                    .foregroundColor(.white)
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
                .foregroundColor(.white)
                .accessibilityHidden(true)
            if togleNotifications {
                Toggle("", isOn: $togleNotifications)
                    .toggleStyle(NotificationsCustomToggleStyle(onColor: UIColor(named: "Light-purple")!, offColor: .darkGray))
                    .accessibilityLabel(Text("Desativar notificações"))
                
            }
            else {
                Toggle("", isOn: $togleNotifications)
                    .toggleStyle(NotificationsCustomToggleStyle(onColor: UIColor(named: "Light-purple")!, offColor: .darkGray))
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
                        .foregroundColor(.white)
                }
                .accessibilityLabel("Voltar")
                Spacer()
            }
            Spacer()
        }
    }
}
