//
//  GameOverView.swift
//  DvdScreensaver
//
//  Created by mvitoriapereirac on 02/11/22.
//



import SwiftUI
import AVFoundation



struct GameOverView: View {
    
    @State var audioPlayer: AVAudioPlayer!
    @State private var shouldShowGame: Bool = false
    @State private var shouldShowAjustes: Bool = false
    var recorde: Int
    var score: Int 
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack{
                HStack{
                    
                    
                    ZStack(alignment: .top) {
                        
                        NavigationLink("",destination: ContentView().navigationBarBackButtonHidden(true) ,isActive: $shouldShowGame)
                        NavigationLink("",destination: Ajustes().navigationBarBackButtonHidden(true) ,isActive: $shouldShowAjustes)
                        
                        
                        Image("backgroundGame")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                        VStack(alignment: .center){
                            Spacer().frame()
                            Image("Game-over")
                            
                            if recorde == score {
                                Text("NOVO RECORDE")
                                    .font(.custom("DaysOne-Regular", size: 20))
                                    .frame(alignment: .topLeading)
                                    .foregroundColor(.yellow)
                            }
                            
                            
                            VStack(spacing: 1){
                                Text("\(score)")
                                    .font(.custom("DaysOne-Regular", size: 60))
                                    .frame(alignment: .topLeading)
                                    .foregroundColor(.white)
                                Text("pontos")
                                    .font(.custom("DaysOne-Regular", size: 20))
                                    .frame(alignment: .topLeading)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                                .frame()
                            Spacer()
                                .frame()
                            
                            Image("raquete")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width * 0.4,height: UIScreen.main.bounds.height * 0.4, alignment: .bottom)
                            
                        }
                        ZStack{
                            TabView{
                                buttonViewJogar()
                                    .onAppear(){
                                        page = 1
                                    }
                                
                                buttonViewAjustes()
                                    .onAppear(){
                                        page = 2
                                    }
                            }.tabViewStyle(PageTabViewStyle())
                            
                        }
                        .padding(.top,UIScreen.main.bounds.height/5)
                        
                    }
                }.onTapGesture {
                    let sound = Bundle.main.path(forResource: "menu", ofType: "mp3")
                    self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                    self.audioPlayer.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        if page == 1 {
                            let sound1 = Bundle.main.path(forResource: "jogar", ofType: "mp3")
                            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                            self.audioPlayer.play()
                        } else {
                            let sound1 = Bundle.main.path(forResource: "ajustes", ofType: "mp3")
                            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                            self.audioPlayer.play()
                        }
                    }
                }.highPriorityGesture(TapGesture( count : 2).onEnded{
                    if page == 1 {
                        shouldShowGame.toggle()
                        shouldShowGame = true
                    } else if page == 2 {
                        shouldShowAjustes.toggle()
                        shouldShowGame = true
                    }
                })
            }
        }
        else {
            // Fallback on earlier versions
            NavigationView{
                HStack{
                    ZStack(alignment: .top) {
                        
                        NavigationLink("",destination: ContentView().navigationBarBackButtonHidden(true) ,isActive: $shouldShowGame)
                        NavigationLink("",destination: DoisDedos().navigationBarBackButtonHidden(true) ,isActive: $shouldShowAjustes)
                        
                        
                        Image("backgroundGame")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                        VStack(alignment: .center){
                            Spacer().frame()
                            Image("Wave-pong")
                            
                            Spacer().frame()
                            
                            Image("menu-border")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4)
                        }
                        ZStack{
                            TabView{
                                buttonViewJogar()
                                    .onAppear(){
                                        page = 1
                                    }
                                
                                buttonViewAjustes()
                                    .onAppear(){
                                        page = 2
                                    }
                            }.tabViewStyle(PageTabViewStyle())
                            
                        }
                        .padding(.top,UIScreen.main.bounds.height/10)
                        
                    }
                }.onTapGesture {
                    let sound = Bundle.main.path(forResource: "menu", ofType: "mp3")
                    self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                    self.audioPlayer.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        if page == 1 {
                            let sound1 = Bundle.main.path(forResource: "jogar", ofType: "mp3")
                            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                            self.audioPlayer.play()
                        } else {
                            let sound1 = Bundle.main.path(forResource: "ajustes", ofType: "mp3")
                            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                            self.audioPlayer.play()
                        }
                    }
                }.highPriorityGesture(TapGesture( count : 2).onEnded{
                    if page == 1 {
                        shouldShowGame.toggle()
                    } else {
                        shouldShowAjustes.toggle()
                    }
                })
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ScrollGameOverViewPagingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
    }
}

extension ScrollView {
    func isGameOverPagingEnabled() -> some View {
        modifier(ScrollViewPagingModifier())
    }
}

struct GameOver_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(recorde: 3, score: 3)
    }
}
