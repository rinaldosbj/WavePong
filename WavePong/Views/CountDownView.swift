//
//  CountDownView.swift
//  WavePong
//
//  Created by rsbj on 21/08/23.
//

import SwiftUI

struct CountDownView: View {
    @State var count = "3"
    
    @State var showGame = false
    
    var body: some View {
        if showGame {
            GameSceneView()
        }
        else {
            ZStack {
                backgroundImageView
                
                Text(count)
                    .foregroundColor(.white)
                    .font(.custom("Strasua-Regular", size: 150))
                    .onAppear{
                        countDown()
                    }
                    .onChange(of: count) { newValue in
                        countDown()
                    }
            }
        }
    }
    
    private var backgroundImageView: some View {
        Image("backgroundGame")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    private func countDown() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            if count == "1" {count = "GO!"}
            else if count == "GO!" {showGame = true}
            else {count = String(Int(count)! - 1)}
        }
    }
    
    
}

struct CountDownView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView()
    }
}
