//
//  ConfigurationView.swift
//  WavePong
//
//  Created by rsbj on 05/08/23.
//

import SwiftUI

struct ConfigurationView: View {
    
    @State var togle : Bool = false
    
    var body: some View {
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
                
                HStack {
                    Text("Notificações")
                        .font(.custom("DaysOne-Regular", size: 24))
                        .layoutPriority(.greatestFiniteMagnitude)
                        .foregroundColor(.white)
                        .accessibilityHidden(true)
                    if togle {
                        Toggle("", isOn: $togle)
                            .toggleStyle(ImageToggleStyle(onColor: UIColor(named: "Light-purple")!, offColor: .darkGray))
                            .accessibilityLabel(Text("Desativar notificações"))
                        
                    }
                    else {
                        Toggle("", isOn: $togle)
                            .toggleStyle(ImageToggleStyle(onColor: UIColor(named: "Light-purple")!, offColor: .darkGray))
                            .accessibilityLabel(Text("Ativar notificações"))
                    }
                }
                
                
            }.padding(.horizontal, 60)
        }
    }
}

struct ImageToggleStyle: ToggleStyle {
    
    var onColor: UIColor
    var offColor: UIColor
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Color(configuration.isOn ? onColor : offColor)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(Color("amarelo"))
                        .padding(.all, 3)
                        .offset(x: configuration.isOn ? 11 : -11, y: 0)
                        .animation(Animation.linear(duration: 0.15),value: configuration.isOn)
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle() }
        }
        
        
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationView()
    }
}
