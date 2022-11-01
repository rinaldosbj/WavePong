//
// ContentView.swift
// DvdScreensaver
//
// Created by rsbj on 18/10/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {

    @AppStorage("Record") var record = 0 // used for storing the record (precistent)
    @State var score: Int = 0
    
    var body: some View {
        GeometryReader{
            geo in
            ZStack{
                SpriteView(scene: skScene)
                    .frame(width: geo.size.width, height: geo.size.height)
                VStack{
                    Text("\(score)")
                        .foregroundColor(.white)
                        .font(.system(size: 500))
                        .minimumScaleFactor(0.01)
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .padding(.top, 70)
                    Text("Pontos")
                        .foregroundColor(.white)
                    Spacer()
                    Text("Record: \(record)")
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .onDisappear(){
                if score > record {
                    record = score
                }
            }
        }
        .ignoresSafeArea()
        .onTapGesture(count: 2, perform: doubleClicked)
        

    }
    
    func doubleClicked() {
        print ("pausa ai")
    }
    
    var skScene: SKScene{ // SKScene lembra muito uma view
        let viewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let ballNode = SKSpriteNode(imageNamed: "neonBall") // Node = Objetos
        ballNode.size = CGSize(width: 60, height: 60)
        
        let raqueteNode = SKSpriteNode(color: .purple, size: CGSize(width: UIScreen.main.bounds.width/2.5, height: 25))
        
        let nuvemNode = SKSpriteNode(imageNamed: "wave")
        nuvemNode.size = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
        
        let nuvemNode2 = SKSpriteNode(imageNamed: "wave2")
        nuvemNode.size = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
        
        let nuvemNode3 = SKSpriteNode(imageNamed: "wave3")
        nuvemNode.size = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
        
        let scene = PongScene(ballNode: ballNode, size: viewFrame.size, raquete: raqueteNode, nuvem: nuvemNode, nuvem2: nuvemNode2, nuvem3: nuvemNode3, score: $score)
        scene.backgroundColor = .darkGray
        
        return scene
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}









