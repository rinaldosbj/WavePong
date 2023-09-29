//
//  OnboardingSceneView.swift
//  WavePong
//
//  Created by Lucas Migge on 25/09/23.
//

import SwiftUI
import SpriteKit


struct OnboardingSceneView: View {
    @Environment(\.dismiss) private var dismiss
    @State var size = CGSize()
    
    var soundManager: SoundManagerProtocol? = SoundManager.shared
    
    
    var scene: OnboardingGameScene {
        let scene = OnboardingGameScene(size: size)
        scene.scaleMode = .resizeFill
        return scene
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
                    .onAppear {
                        size = geo.size
                        soundManager?.playGameTheme()
                        
                    }
                VStack {
                    HStack {
                        Image("settings")
                            .onTapGesture {
                                soundManager?.stopGameTheme()
                                dismiss()
                            }
                            .padding()
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                
                
            }
            
        }
        
    }
}

#Preview {
    OnboardingSceneView()
}
