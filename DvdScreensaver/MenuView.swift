//
//  testando.swift
//  DvdScreensaver
//
//  Created by sofia.ribeiro on 01/11/22.
//

import SwiftUI
import AVFoundation

var page : Int = 0

struct buttonViewJogar: View{
    var body: some View {
        ZStack{
            Color.clear
            
            VStack(alignment: .center){
                Button(action: {}) {
                    Text("Jogar")
                }
                .buttonStyle(MyActionButtonStyle())
            }
        }.frame(width: UIScreen.main.bounds.width + 70)
    }
}

struct buttonViewAjustes: View{
    var body: some View {
        ZStack{
            Color.clear
            
            VStack(alignment: .center){
                Button(action: {}) {
                    Text("Ajustes")
                }
                .buttonStyle(MyActionButtonStyle())
            }
        }.frame(width: UIScreen.main.bounds.width + 70)
    }
    
}

struct MenuView: View {
    
    @State var audioPlayer: AVAudioPlayer!
    @State private var shouldShowGame: Bool = false
    @State private var shouldShowAjustes: Bool = false
    var contentView = ContentView()
    
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
                            Image("Wave-pong")
                            Spacer().frame()
                            
                            HStack{
                                Text("\(Text("Record:").foregroundColor(.yellow)) \(contentView.record)")
                                    .font(.custom("DaysOne-Regular", size: 30))
                                    .foregroundColor(.white)
                            }
                            
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
                    } else if page == 2 {
                        shouldShowAjustes.toggle()
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

struct ScrollViewPagingModifier: ViewModifier {
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
    func isPagingEnabled() -> some View {
        modifier(ScrollViewPagingModifier())
    }
}

struct testando_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
