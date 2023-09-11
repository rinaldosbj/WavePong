//
//  PausarView.swift
//  WavePong
//
//  Created by rsbj on 14/08/23.
//

import SwiftUI

struct PausarView: View {
    @State var scale: CGFloat = 1.0
    @State var animation = false
    
    let stringsConstants = StringsConstantsModel()
    
    var body: some View {
        ZStack{
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            VStack(alignment: .center, spacing: 60 ){
                Text(stringsConstants.dois_toques)
                    .font(.custom("DaysOne-Regular", size: 35))
                    .foregroundColor(Color(ColorConstants.shared.WHITE_500))
                    .bold()
                    .minimumScaleFactor(15)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    .accessibilityHint(stringsConstants.onboading_hint)
                
                HStack{
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                        .padding(10)
                        .blur(radius: scale, opaque: false)
                        .foregroundColor(Color(ColorConstants.shared.YELLOW_600))
                        .accessibilityHidden(true)
                        .overlay(
                            ZStack{
                                Circle()
                                    .stroke(Color(ColorConstants.shared.YELLOW_600))
                                    .frame(width: 100, height: 100)
                                    .blur(radius: scale)
                                    .scaleEffect(scale)
                                    .opacity(Double(2 - scale))
                                    .animation(.easeOut(duration: 3).repeatForever(autoreverses: false), value: animation)
                                Circle()
                                    .stroke(Color(ColorConstants.shared.YELLOW_600))
                                    .frame(width: 100, height: 100)
                                    .blur(radius: scale)
                                    .scaleEffect(scale - 0.5)
                                    .opacity(Double(2 - scale))
                                    .animation(.easeOut(duration: 3).repeatForever(autoreverses: false), value: animation)
                            }
                        )
                        .accessibilityHidden(true)
                        .onAppear{
                            scale += 1
                            animation = true
                        }
                }
            }
        }
    }
}

struct PausarView_Previews: PreviewProvider {
    static var previews: some View {
        PausarView()
    }
}
