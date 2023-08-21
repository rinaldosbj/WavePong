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
                    NavigationLink(destination: {
                        GameSceneView()
                            .navigationBarBackButtonHidden()
                    }) {
                        LabelButton(buttonStyle: .start, buttonAction:{})
                    }
                    .foregroundColor(.yellow)
                    .accessibilityLabel("começar")
                    Spacer().frame(height: 48)
                    HStack {
                        NavigationLink(destination: {
                            ConfigurationView()
                        }) {
                            IconButton(.settings, buttonType: .link, buttonAction: {})
                        }
                            .foregroundColor(.yellow)
                            .accessibilityLabel("Configurações")
                            .padding(.trailing,48)
                        NavigationLink(destination: {
                            SoundBoardView()
                        }) {
                            IconButton(.gameCenter, buttonType: .link, buttonAction: {})
                        }
                            .foregroundColor(.yellow)
                            .accessibilityLabel("game center")
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
