//
//  MenuView.swift
//  WavePong
//
//  Created by rsbj on 04/08/23.
//

import SwiftUI


struct MenuView: View {
    
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                Image("backgroundGame")
                    .resizable()
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                VStack() {
                    Image("Wave-pong")
                        .accessibilityHidden(true)
                    Spacer().frame(height: 192)
                    NavigationLink {
                        SelectDifficultyView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        LabelButton(buttonStyle: .start, buttonAction:{})
                    }
                    .foregroundColor(.yellow)
                    .accessibilityLabel("jogar")
                    .accessibilityHint("Toque duas vezes na tela para começar um novo jogo")
                    Spacer().frame(height: 48)
                    HStack {
                        NavigationLink(destination: {
                            ConfigurationView()
                                .navigationBarBackButtonHidden()
                        }) {
                            IconButton(.settings, buttonType: .link, buttonAction: {})
                        }
                            .foregroundColor(.yellow)
                            .accessibilityLabel("Configurações")
                            .accessibilityHint("Toque duas vezes na tela para ir para a tela de configurações")
                            .padding(.trailing,48)
                        NavigationLink(destination: {
                            ComingSoonView()
                                .navigationBarBackButtonHidden()
                        }) {
                            IconButton(.gameCenter, buttonType: .link, buttonAction: {})
                        }
                            .foregroundColor(.yellow)
                            .accessibilityLabel("game center")
                            .accessibilityHint("Toque duas vezes na tela para ir para a tela do game Center")
                    }
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
