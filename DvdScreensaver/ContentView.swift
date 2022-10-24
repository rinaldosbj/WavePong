//
//  ContentView.swift
//  DvdScreensaver
//
//  Created by rsbj on 18/10/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var body: some View {
        GeometryReader{
            geo in
            ZStack{
                SpriteView(scene: skScene)
                    .frame(width: geo.size.width, height: geo.size.height)
            }.onTapGesture {
                aaa()
            }
        }.ignoresSafeArea()
    }
    
    var skScene: SKScene{
        let viewFrame = CGRect(x: 0.5, y: 0.5, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let view = SKView(frame: viewFrame)
        let ballNode = SKSpriteNode(imageNamed: "neonBall")
        ballNode.size = CGSize(width: 60, height: 60)
        
        let raqueteNode = SKSpriteNode(color: .purple, size: CGSize(width: 150, height: 20))
        let nuvemNode = SKSpriteNode(color: .systemPurple, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        let scene = PongScene(ballNode: ballNode, size: view.frame.size, raquete: raqueteNode, nuvem: nuvemNode)
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .darkGray
        
        return scene
    }
    
    func aaa(){
       // print(skScene.childNode(withName: "ballNode")?.position)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

