//
//  ComingSoonView.swift
//  WavePong
//
//  Created by rsbj on 23/08/23.
//

import SwiftUI

struct ComingSoonView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack{
            Image("backgroundGame")
                .resizable()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            VStack{
                Text("Em breve")
                    .font(.custom("DaysOne-Regular", size: 36))
                    .layoutPriority(.greatestFiniteMagnitude)
                    .foregroundColor(.white)
                    .accessibilityLabel("Disponível em breve")
            }
            
            HStack {
                VStack {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Text("  < Voltar")
                            .font(.custom("DaysOne-Regular", size: 24))
                            .layoutPriority(.greatestFiniteMagnitude)
                            .foregroundColor(.white)
                    }
                    .accessibilityLabel("Voltar")
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct ComingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoonView()
    }
}
