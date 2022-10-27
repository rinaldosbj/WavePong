//
// ContentView.swift
// DvdScreensaver
//
// Created by rsbj on 18/10/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @StateObject var user = UserScore()
    
    var body: some View {
        GeometryReader{
            geo in
            ZStack{
                SpriteView(scene: skScene)
                    .frame(width: geo.size.width, height: geo.size.height)
                VStack{
                    Text("\(user.score)")
                        .font(.system(size: 5000))
                        .minimumScaleFactor(0.01)
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .padding(.top, 40)
                    Text("Pontos")
                    Spacer()
                }
            }.onTapGesture {
                print("aa\(user.score)")
            }
        }.ignoresSafeArea()
    }
    
    var skScene: SKScene{ // SKScene lembra muito uma view
        let viewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let ballNode = SKSpriteNode(imageNamed: "neonBall") // Node = Objetos
        ballNode.size = CGSize(width: 60, height: 60)
        
        let raqueteNode = SKSpriteNode(color: .purple, size: CGSize(width: UIScreen.main.bounds.width/2.5, height: 25))
        let nuvemNode = SKSpriteNode(color: .systemPurple, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        let scene = PongScene(ballNode: ballNode, size: viewFrame.size, raquete: raqueteNode, nuvem: nuvemNode)
        scene.backgroundColor = .darkGray
        
        return scene
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}









