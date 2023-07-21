//
//  testando.swift
//  DvdScreensaver
//
//  Created by rsbj on 02/11/22.
//

import SwiftUI
import AVFoundation

var pageAjustes : Int = 0
var telaAtiva: Bool = true
var vibracaoAtiva: Bool = true
var guiaAtivo: Bool = true

struct Ajustes: View {
    
    @State var audioPlayer: AVAudioPlayer!
    @State var ativoTela: Bool = true
    @State var ativoGuia: Bool = true
    @State var ativoVibracao: Bool = true
    @State private var shouldShow: Bool = false
    
    var body: some View{
        ZStack{
            NavigationLink("",destination: MenuView().navigationBarBackButtonHidden(true) ,isActive: $shouldShow)
            
            ZStack{
                Image("backgroundGame")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center){
                    Button(action: {}) {
                        Text("Ajustes")
                    }
                    .buttonStyle(MyActionButtonStyle())
                    .padding(.top, UIScreen.main.bounds.height/8)
                    Spacer()
                }
                
                TabView{
                    telaAjustes(ativo: $ativoTela)
                        .onAppear(){
                            pageAjustes = 1
                        }
                    telaGuia(ativo: $ativoGuia)
                        .onAppear(){
                            pageAjustes = 2
                        }
                    telaVibracao(ativo: $ativoVibracao)
                        .onAppear(){
                            pageAjustes = 3
                        }
                }.tabViewStyle(PageTabViewStyle())
                    .highPriorityGesture(TapGesture( count : 2).onEnded{
                        if pageAjustes == 1 {
                            telaAtiva.toggle()
                            ativoTela.toggle()
                        } else if pageAjustes == 2 {
                            guiaAtivo.toggle()
                            ativoGuia.toggle()
                        } else if pageAjustes == 3 {
                            vibracaoAtiva.toggle()
                            ativoVibracao.toggle()
                        }
                    })
                    .onTapGesture {
                        
                        let sound = Bundle.main.path(forResource: "ajustes", ofType: "mp3")
                        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                        self.audioPlayer.play()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            
                            if pageAjustes == 1 && telaAtiva{
                                let sound1 = Bundle.main.path(forResource: "desativartela", ofType: "mp3")
                                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                                self.audioPlayer.play()
                                
                            }
                            else if pageAjustes == 1 && !telaAtiva{
                                let sound1 = Bundle.main.path(forResource: "ativartela", ofType: "mp3")
                                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                                self.audioPlayer.play()
                                
                            }
                            else if pageAjustes == 2 && guiaAtivo{
                                let sound1 = Bundle.main.path(forResource: "desativarguiaauditivo", ofType: "mp3")
                                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                                self.audioPlayer.play()
                            }
                            else if pageAjustes == 2 && !guiaAtivo{
                                print("guia desativo")
                            }
                            else if pageAjustes == 3 && vibracaoAtiva {
                                let sound1 = Bundle.main.path(forResource: "desativarvibracao", ofType: "mp3")
                                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                                self.audioPlayer.play()
                            } else if pageAjustes == 3 && !vibracaoAtiva {
                                let sound1 = Bundle.main.path(forResource: "ativarvibracao", ofType: "mp3")
                                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound1!))
                                self.audioPlayer.play()
                            }
                        }
                    }
            }
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image("comingsoon")
                        .padding()
                }
            }
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    shouldShow.toggle()
                }
            }
        }
    }
}

struct telaAjustes: View{
    @Binding var ativo: Bool
    var body: some View{
        if ativo {
            Text("\(Text("Desativar").foregroundColor(.yellow)) tela")
                .font(.custom("DaysOne-Regular", size: 35))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 310, height: 270, alignment: .center)
        }
        else {
            Text("\(Text("Ativar").foregroundColor(.yellow)) tela")
                .font(.custom("DaysOne-Regular", size: 35))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 310, height: 270, alignment: .center)
        }
    }
}

struct telaVibracao: View{
    @Binding var ativo: Bool
    var body: some View{
        if ativo {
            Text("\(Text("Desativar").foregroundColor(.yellow)) vibracao")
                .font(.custom("DaysOne-Regular", size: 35))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 310, height: 270, alignment: .center)
        }
        else {
            Text("\(Text("Ativar").foregroundColor(.yellow)) vibracao")
                .font(.custom("DaysOne-Regular", size: 35))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 310, height: 270, alignment: .center)
        }
    }
}

struct telaGuia: View{
    @Binding var ativo: Bool
    var body: some View{
        if ativo {
            Text("\(Text("Desativar").foregroundColor(.yellow)) guia auditivo")
                .font(.custom("DaysOne-Regular", size: 35))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 310, height: 270, alignment: .center)
        }
        else {
            Text("\(Text("Ativar").foregroundColor(.yellow)) guia auditivo")
                .font(.custom("DaysOne-Regular", size: 35))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 310, height: 270, alignment: .center)
        }
    }
}

struct Ajustes_Previews: PreviewProvider {
    static var previews: some View {
        Ajustes()
    }
}
