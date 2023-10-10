//
//  StoreCard.swift
//  WavePong
//
//  Created by LoreVilaca on 27/09/23.
//

import SwiftUI

struct StoreCardButton: View {    
    
//    enum ButtonStoreStyle: String {
//        case buy, use
//    }
//    
//    var buttonStyle: ButtonStoreStyle
//    
//    init(_ buttonStyle: ButtonStoreStyle) {
//        self.buttonStyle = buttonStyle
//    }
//    
//    
//    private var buttonString: String {
//        switch buttonStyle {
//        case .buy:
//            return "COMPRAR"
//        case .use:
//            return "USAR"
//        }
//    }
    
    var body: some View {
        HStack{
            
            ZStack {
                Rectangle()
                    .fill(Color(ColorConstants.shared.WHITE_500))
                    .roundedCorner(24,corners: [.topLeft, .bottomRight])
                    .frame(width: 157, height: 47)
                
                Rectangle()
                    .fill(Color(ColorConstants.shared.PURPLE_500))
                    .roundedCorner(23,corners: [.topLeft, .bottomRight])
                    .frame(width: 153, height: 43)
                    .overlay {
                        Text("USAR")
                            .font(Font.wavePongPrimary(.caption))
                    }
            }
        }.background(Color.black)
    }
}
    

struct StoreCardButton_Previews: PreviewProvider {
    static var previews: some View {
        StoreCardButton()
    }
}
