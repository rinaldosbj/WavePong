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
    @Binding var didColide: Bool
    
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
    
    var shouldVibrate: Bool {
        switch demoCase {
        case .game:
           return  true
        default:
            return false
        }
    }
    
    var soundManager: SoundManagerProtocol? = SoundManager.shared
    
    var scene: OnboardingGameScene {
        let scene = OnboardingGameScene(size: size, strategy: strategy, shouldVibrate: shouldVibrate, didColide: $didColide)
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
                    .onChange(of: didColide, perform: {newValue in
                        didColide = true
                    })
                
            }
            
        }
        
    }
}

