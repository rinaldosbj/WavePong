//
//  Menu.swift
//  DvdScreensaver
//
//  Created by mvitoriapereirac on 01/11/22.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    
                VStack{
                    Spacer()
                    Image("Wave-pong")
                        .frame(alignment: .center)
                    Spacer()
                    
                    Image("menu-border")
                        .frame(alignment: .bottom)
                }
                

            }

            .ignoresSafeArea()
        }
        
    }
}

struct menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
