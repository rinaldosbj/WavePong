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
                VStack(spacing:geo.size.height/8) {
                    Image("Wave-pong", label: Text("Logo, Wave Pong"))
                    NavigationLink("Jogar", destination: ContentView().navigationBarBackButtonHidden())
                        .foregroundColor(.yellow)
                        .accessibilityLabel("jogar")
                    NavigationLink("Configurações", destination: ConfigurationView())
                        .foregroundColor(.yellow)
                        .accessibilityLabel("Configurações")
                    NavigationLink("Sound Board", destination: SoundBoardView())
                        .foregroundColor(.yellow)
                        .accessibilityLabel("Sound Board")
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
