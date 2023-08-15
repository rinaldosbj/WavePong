//
//  OnboardingView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var viewState = 5
    
    var body: some View {
        Group{
            switch viewState {
            case 5:
                FoneView()
                    .onTapGesture { viewState -= 1 }
            case 4:
                RaqueteView()
                    .accessibilityHint("Deslize os dedos para os lados para mover a raquete e rebater a bola")
                    .accessibilityRespondsToUserInteraction()
                    .accessibilityAddTraits(.allowsDirectInteraction)
                    .highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                        .onEnded { value in
                            if abs(value.translation.height) < abs(value.translation.width) {
                                if abs(value.translation.width) > 50.0 {
                                    if value.translation.width < 0 {
                                        self.swipe()
                                    } else if value.translation.width > 0 {
                                        self.swipe()
                                    }
                                }
                            }
                        }
                    )
            case 3:
                PosicaoView()
                    .onTapGesture { viewState -= 1 }
            case 2:
                RebaterView()
                    .onTapGesture { viewState -= 1 }
            case 1:
                PausarView()
                    .onTapGesture { viewState -= 1 }
            default:
                GameSceneView()
                    .navigationBarBackButtonHidden()
                    .accessibilityRespondsToUserInteraction()
                    .accessibilityElement()
                    .accessibilityAddTraits(.allowsDirectInteraction)
            }
        }.id(viewState)
    }
    
    func swipe() {
        viewState -= 1
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
