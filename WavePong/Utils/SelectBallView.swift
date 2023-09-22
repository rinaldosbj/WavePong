//
//  SelectBallView.swift
//  WavePong
//
//  Created by rsbj on 06/09/23.
//

import SwiftUI

struct SelectBallView: View {
    
    var player: PlayerProtocol = Player.shared
    
    @State var selectedBall: PreviousBallSkin = .ball_yellow
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Selecione a Bola")
                    .font(.title2)
                
                HStack {
                    Text("Selecionado:")
                        .onAppear {
                            selectedBall = player.selectedBall
                        }
                    Spacer()
                    switch selectedBall {
                    case .ball_yellow:
                        Text("Yellow")
                            .foregroundColor(.yellow)
                    case .ball_green:
                        Text("Green")
                            .foregroundColor(.green)
                    case .ball_cyan:
                        Text("Cyan")
                            .foregroundColor(.cyan)
                    case .ball_blue:
                        Text("Blue")
                            .foregroundColor(.blue)
                    case .ball_purple:
                        Text("Purple")
                            .foregroundColor(.purple)
                    case .ball_red:
                        Text("Red")
                            .foregroundColor(.red)
                    case .ball_orange:
                        Text("Orange")
                            .foregroundColor(.orange)
                    }
                }.padding(20)
                
                ForEach(PreviousBallSkin.allCases, id: \.self) {
                    type in
                    Button {
                        player.changeBall(type)
                        selectedBall = type
                    } label: {
                        HStack {
                            switch type {
                            case .ball_yellow:
                                Text("Yellow")
                            case .ball_green:
                                Text("Green")
                            case .ball_cyan:
                                Text("Cyan")
                            case .ball_blue:
                                Text("Blue")
                            case .ball_purple:
                                Text("Purple")
                            case .ball_red:
                                Text("Red")
                            case .ball_orange:
                                Text("Orange")
                            }
                            Spacer()
                            Text("<-")
                        }
                        .padding(20)
                    }
                    .padding(.horizontal,20)
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

struct SelectBallView_Previews: PreviewProvider {
    static var previews: some View {
        SelectBallView()
    }
}
