//
//  ArrasteDireita.swift
//  DvdScreensaver
//
//  Created by Mariane Vilarim on 27/10/22.
//

import SwiftUI

struct ArrasteDireita: View {
    var body: some View {
        VStack{
            Text("Arraste para os lados para navegar pelo menu")
                .font(.custom("DaysOne-Regular", size: 35))
                    .bold()
                    .padding()
                    .onTapGesture(count: 1) {
                        print("toquei")
                    }
            Image("arraste direita")
        }
    }
}

struct ArrasteDireita_Previews: PreviewProvider {
    static var previews: some View {
        ArrasteDireita()
    }
}
