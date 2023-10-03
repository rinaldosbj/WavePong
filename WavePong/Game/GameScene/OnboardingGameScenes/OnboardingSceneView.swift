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
    @State var demoCase: DemoCase
    
    enum DemoCase {
        case pan, volume, game
    }
    
    var strategy: OnboardingGameSceneStrategy {
        switch demoCase {
        case .pan:
           return  PanOnboardingStrategy()
        case .volume:
           return  VolumeOnboardingStrategy()
        case .game:
           return  PanAndVolumeOnboardingStrategy()
        }
    }
    
    var soundManager: SoundManagerProtocol? = SoundManager.shared
    
    
    var scene: OnboardingGameScene {
        let scene = OnboardingGameScene(size: size, strategy: strategy)
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
    OnboardingSceneView(demoCase: .volume)
}
