//
//  GameOverView.swift
//  DvdScreensaver
//
//  Created by mvitoriapereirac on 02/11/22.
//



import SwiftUI
import AVFoundation

var pageMenu = 1

struct buttonViewMenu: View{
    var body: some View {
        ZStack{
            Color.clear
            
            VStack(alignment: .center){
                Button(action: {}) {
                    Text("Menu")
                }
                .buttonStyle(MyActionButtonStyle())
            }
        }.frame(width: UIScreen.main.bounds.width + 70)
    }
    
}

struct GameOverView: View {
    
    @State var audioPlayer: AVAudioPlayer!
    @State private var shouldShowGame: Bool = false
    @State private var shouldShowMenu: Bool = false
    var recorde: Int
    var score: Int
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack{
                HStack{
                    
                    
                    ZStack(alignment: .top) {
                        
                        NavigationLink("",destination: ContentView().navigationBarBackButtonHidden(true) ,isActive: $shouldShowGame)
                        NavigationLink("",destination: MenuView().navigationBarBackButtonHidden(true) ,isActive: $shouldShowMenu)
                        
                        
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
                                        pageMenu = 1
                                    }
                                
                                buttonViewMenu()
                                    .onAppear(){
                                        pageMenu = 2
                                    }
                            }.tabViewStyle(PageTabViewStyle())
                            
                        }
                        .padding(.top,UIScreen.main.bounds.height/5)
                        
                    }
                }.onTapGesture {
                    if pageMenu == 1 {
                        let sound1 = Bundle.main.path(forResource: "jogar", ofType: "mp3")
                        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                        self.audioPlayer.play()
                    } else {
                        let sound1 = Bundle.main.path(forResource: "menu", ofType: "mp3")
                        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                        self.audioPlayer.play()
                    }
                }.highPriorityGesture(TapGesture( count : 2).onEnded{
                    if pageMenu == 1 {
                        shouldShowGame.toggle()
                        shouldShowGame = true
                    } else if pageMenu == 2 {
                        shouldShowMenu.toggle()
                        shouldShowMenu = true
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
                        NavigationLink("",destination: MenuView().navigationBarBackButtonHidden(true) ,isActive: $shouldShowMenu)
                        
                        
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
                                        pageMenu = 1
                                    }
                                
                                buttonViewMenu()
                                    .onAppear(){
                                        pageMenu = 2
                                    }
                            }.tabViewStyle(PageTabViewStyle())
                            
                        }
                        .padding(.top,UIScreen.main.bounds.height/5)
                        
                    }
                }.onTapGesture {
                    if pageMenu == 1 {
                        let sound1 = Bundle.main.path(forResource: "jogar", ofType: "mp3")
                        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                        self.audioPlayer.play()
                    } else {
                        let sound1 = Bundle.main.path(forResource: "menu", ofType: "mp3")
                        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                        self.audioPlayer.play()
                    }
                }.highPriorityGesture(TapGesture( count : 2).onEnded{
                    if pageMenu == 1 {
                        shouldShowGame.toggle()
                        shouldShowGame = true
                    } else if pageMenu == 2 {
                        shouldShowMenu.toggle()
                        shouldShowMenu = true
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
