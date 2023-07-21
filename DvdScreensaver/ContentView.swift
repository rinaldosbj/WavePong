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
    
    @State var shouldNav = false
    @State var shouldReload = false
    
    @State var shouldShowGameOver: Bool = false 
    
    
    
    var body: some View {
        GeometryReader{
            geo in
            ZStack{
                
                NavigationLink("",destination: MenuView().navigationBarBackButtonHidden(true), isActive: $shouldNav)
                
                NavigationLink("",destination: ContentView().navigationBarBackButtonHidden(true), isActive: $shouldReload)
                NavigationLink("",destination: GameOverView(recorde: record, score: score).navigationBarBackButtonHidden(true), isActive: $shouldShowGameOver)
                
                SpriteView(scene: skScene)
                
                
                VStack{
                    
                    VStack(spacing: 5) {
                        
//                        Text("\n \n \nCLIQUE DUAS VEZES NA TELA PARA PAUSAR")
//                            .foregroundColor(.white)
//                            .font(.custom("DaysOne-Regular", size: 13))
//                            .frame(alignment: .topLeading)
                        
                        Text("\(score)")
                            .foregroundColor(.white)
                            .font(.custom("DaysOne-Regular", size: 100))
                            .minimumScaleFactor(0.01)
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .padding(.top, 70)
                        
                        Text("PONTOS")
                            .foregroundColor(.white)
                            .font(.custom("DaysOne-Regular", size: 20))
                    }
                    
                    Spacer()
                    
                }
            }
            .onDisappear(){
                if score > record {
                    record = score
                }
            }
            
            //            .popup(isPresented: $shouldShowPopUp) {
            //                ZStack {
            //                    Color.white.opacity(0.2)
            //                    Color.black.frame(width: geo.size.width * 3/4, height: geo.size.height * 3/4)
            //                        .cornerRadius(20)
            //
            //                    if gamePaused == true {
            //                        VStack(spacing: 40){
            //                            Image("Pause")
            //                            ScrollView(.horizontal){
            //                                LazyVGrid(columns: popUpRows) {
            //                                    Button("Retornar ao jogo") {
            //                                        gamePaused = false
            //                                        shouldShowPopUp = false
            //
            //
            //
            //                                    }
            //
            //                                    Button("Menu") {
            //                                        shouldNav = true
            //                                    }
            //                                }
            //                            }
            //
            //
            //                        }
            //                        .frame(width: geo.size.width * 3/4, height: 400, alignment: .center)
            //
            //                    }else{
            //                        VStack(spacing: 40){
            //
            //                            Image("Game-over")
            //
            //                            Text("Novo recorde")
            //                                .foregroundColor(.yellow)
            //
            //                            Text("\(score) \n pontos")
            //                                .foregroundColor(.white)
            //
            //
            //                            LazyVGrid(columns:
            //                                        popUpRows) {
            //                                //
            //
            //                                Button("Novo jogo") {
            //                                    score = 0
            //                                    gamePaused = false
            //                                    shouldReload = true
            //
            //                                }
            //                                .padding(30)
            //                                .foregroundColor(.white)
            //                                .buttonStyle(.borderedProminent)
            //                                .tint(.purple)
            //
            //                                Button("Menu") {
            //                                    shouldNav = true
            //                                }
            //                                .padding(30)
            //                                .foregroundColor(.white)
            //                                .buttonStyle(.borderedProminent)
            //                                .tint(.purple)
            //
            //                                Button("Ajustes") {
            //                                    print("oi")
            //                                }
            //                                .padding(30)
            //                                .foregroundColor(.white)
            //                                .buttonStyle(.borderedProminent)
            //                                .tint(.purple)
            //
            //                            }
            //                                        .offset(x: sliderPosition + offset.width)
            //                                        .frame(width: geo.size.width * 2/4)
            //                                        .fixedSize()
            //
            //
            //                                        .gesture(
            //                                            DragGesture()
            //                                                .updating($offset, body: { (value, state, transaction) in
            //                                                    state = value.translation
            //                                                })
            //                                                .onEnded({ (value) in
            //                                                    if value.translation.width < -geo.size.width * 0.4 {
            //                                                        //                                                            sliderPosition = 80 - (geo.size.width / 2)
            //
            //                                                        sliderPosition = sliderPosition - (200 + geo.size.width/4)
            //
            //
            //
            //
            //                                                    } else {
            //
            //                                                        sliderPosition = sliderPosition + (200 + geo.size.width/4)
            //
            //                                                        //                                                            sliderPosition = 0
            //
            //                                                    }
            //                                                })
            //                                        )
            //                                        .animation(.spring())
            //
            //                            //                            }
            //
            //
            //                        }
            //                        .frame(width: geo.size.width * 3/4, height: 400, alignment: .center)
            //
            //                    }
            //                }
            //
            //            }
            //            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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



