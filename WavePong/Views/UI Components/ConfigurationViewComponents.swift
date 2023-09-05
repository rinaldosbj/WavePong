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
            Text(stringsConstants.tutorial)
                .font(.custom("DaysOne-Regular", size: 24))
                .foregroundColor(.white)
                .underline(color:Color("amarelo"))
        }
    }
    
    var soundModeConfigView: some View {
        VStack {
            HStack {
                Text(stringsConstants.modo_som)
                    .accessibilityHint(stringsConstants.modo_hint)
                    .font(.custom("DaysOne-Regular", size: 24))
                    .foregroundColor(.white)
                Spacer()
            }
            
            HStack {
                Toggle("", isOn: $togleIsLinear)
                    .toggleStyle(SelectCustomToggleStyle(mode: .linear))
                    .foregroundColor(.white)
                    .accessibilityLabel(stringsConstants.linear_hint)
                    .onChange(of: togleIsLinear) { _ in
                        updateToggle(from: .linear)
                    }
                Spacer()
            }
            HStack {
                Toggle("",isOn: $togleIsCurved)
                    .toggleStyle(SelectCustomToggleStyle(mode: .curved))
                    .foregroundColor(.white)
                    .accessibilityLabel(stringsConstants.exponencial_hint)
                    .onChange(of: togleIsCurved) { _ in
                        updateToggle(from: .curved)
                    }
                Spacer()
            }
            
            HStack {
                Toggle("",isOn: $togleIsHighContrast)
                    .toggleStyle(SelectCustomToggleStyle(mode: .highContrast))
                    .foregroundColor(.white)
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
                    Text(stringsConstants.volta)
                        .font(.custom("DaysOne-Regular", size: 24))
                        .layoutPriority(.greatestFiniteMagnitude)
                        .foregroundColor(.white)
                }
                .accessibilityLabel(stringsConstants.volta_hint)
                Spacer()
            }
            Spacer()
        }
    }
}
