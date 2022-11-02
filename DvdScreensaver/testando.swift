//
//  testando.swift
//  DvdScreensaver
//
//  Created by sofia.ribeiro on 01/11/22.
//

import SwiftUI

struct MyActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("DaysOne-Regular", size: 30))
            .foregroundColor(.white)
            .frame(height: 67)
            .frame(width: 267)
            .background(
               Image("button")
                )
    }
}

struct testando: View {
    var body: some View {
        NavigationView{
            ZStack(alignment: .top) {
                Image("backgroundGame")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                Spacer()
                    .frame(height: 100)
//                    Image("logo")
                Image("Wave-pong")
                    .padding(40)

//                    .padding(.leading, 20)
//                        .padding(.bottom, 300)
                    
            Spacer()
                .frame(height: 190)
                    
                ScrollView(.horizontal){
                        
            HStack(alignment: .bottom ,spacing: 94){
//                    Spacer()
                               
                            
                Button(action: {}) {
                    Text("Jogar")
                            }
                    .buttonStyle(MyActionButtonStyle())
                            
                            

                    Button(action: {}) {
                    Text("Ajustes")
                            }
                    .buttonStyle(MyActionButtonStyle())
                            
                    .padding(.horizontal, 20)
                        }
                    }
                    
                Image("menu-border")
                    .frame(alignment: .bottom)
                }
            }
        }
    }
}

struct testando_Previews: PreviewProvider {
    static var previews: some View {
        testando()
    }
}
