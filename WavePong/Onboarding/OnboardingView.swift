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
                    .onTapGesture { viewState -= 1 }
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
                ContentView()
            }
        }.id(viewState)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
