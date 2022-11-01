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
    @State var shouldShowPopUp: Bool = false
    let popUpRows: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width / 3 + 130), spacing: 30),
                                 GridItem(.fixed(UIScreen.main.bounds.width / 3 + 130), spacing: 30),
                                 GridItem(.fixed(UIScreen.main.bounds.width / 3 + 130), spacing: 30)
                                
                                 ]
    
    @State var gamePaused: Bool = false
    @State private var sliderPosition: CGFloat = 80 - UIScreen.main.bounds.width
    @GestureState private var offset = CGSize.zero
    
    
    
    var body: some View {
        GeometryReader{
            geo in
            ZStack{

                
                if gamePaused == false {
                    SpriteView(scene: skScene)
                        .onTapGesture(count: 2) {
                            gamePaused = true
                            shouldShowPopUp = true
                        }
                }
                
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
            }.onDisappear(){
                if score > record {
                    record = score
                }
            }
            
            .popup(isPresented: $shouldShowPopUp) {
                ZStack {
                    Color.black.frame(width: geo.size.width * 3/4, height: 400)
                    
                    if gamePaused == true {
                        VStack(spacing: 40){
                            Image("Pause")
                            ScrollView(.horizontal){
                                LazyVGrid(columns: popUpRows) {
                                    Button("Retornar ao jogo") {
                                        gamePaused = false
                                        shouldShowPopUp = false

                                            
                                        
                                    }
                                    
                                    Button("Menu") {
                                        print("oi")
                                    }
                                }
                            }
                            
                            
                        }
                        .frame(width: geo.size.width * 3/4, height: 400, alignment: .center)
                        
                    }else{
                        VStack(spacing: 40){
                            
                            Image("Game-over")
//                            ScrollView(.horizontal) {
                                LazyVGrid(columns:
                                            popUpRows) {
//                                    Button("") {
//                                        print("botao placeholder")
//
//
//
//                                    }
                                    
                                    
                                    
                                    Button("Menu") {
                                        print("oi")
                                    }
                                    
                                    Button("novo jogo") {
                                        score = 0
                                        gamePaused = false
                                        
                                        print("passou aqui")


                                        
                                        

                                    }
                                    
                                    Button("Ajustes") {
                                        print("oi")
                                    }
                                    
                                    
//                                    Button("") {
//                                        print("botao placeholder")
//
//
//
//                                    }
                                    
                                }
                                            .offset(x: sliderPosition + offset.width)
                                            .frame(width: geo.size.width * 2/4)
                                            

                                            .simultaneousGesture(
                                                DragGesture()
                                                    .updating($offset, body: { (value, state, transaction) in
                                                        state = value.translation
                                                    })
                                                    .onEnded({ (value) in
                                                        if value.translation.width < -geo.size.width * 0.4 {
//                                                            sliderPosition = 80 - (geo.size.width / 2)
                                                            sliderPosition = sliderPosition - (200 + geo.size.width/4)
                                    
                                                            
                                                        } else {
                                                            sliderPosition = sliderPosition + (200 + geo.size.width/4)
                                                        }
                                                    })
                                            )
            
//                            }
                            
                         
                        }
                        .frame(width: geo.size.width * 3/4, height: 400, alignment: .center)

                    }
                }

            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)

        }.ignoresSafeArea()
        
    }
    
    
    
    var skScene: SKScene{ // SKScene lembra muito uma view
        let viewFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let ballNode = SKSpriteNode(imageNamed: "neonBall") // Node = Objetos
        ballNode.size = CGSize(width: 60, height: 60)
        
        let raqueteNode = SKSpriteNode(imageNamed: "raquete")
        raqueteNode.size = CGSize(width: UIScreen.main.bounds.width/2.5, height: 25)
        
        let nuvemNode = SKSpriteNode(imageNamed: "wave")
        nuvemNode.size = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
        
        let nuvemNode2 = SKSpriteNode(imageNamed: "wave2")
        nuvemNode.size = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
        
        let nuvemNode3 = SKSpriteNode(imageNamed: "wave3")
        nuvemNode.size = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height)
        
        let scene = PongScene(ballNode: ballNode, size: viewFrame.size, raquete: raqueteNode, nuvem: nuvemNode, nuvem2: nuvemNode2, nuvem3: nuvemNode3, score: $score, deveMostrar: $shouldShowPopUp, pausou: $gamePaused)
        scene.backgroundColor = .darkGray
        
        return scene
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}


extension View {
    
    public func popup<PopupContent: View>(
        isPresented: Binding<Bool>,
        view: @escaping () -> PopupContent) -> some View {
            self.modifier(
                Popup(
                    isPresented: isPresented,
                    view: view)
            )
        }
}






