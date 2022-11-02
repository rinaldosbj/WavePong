//
//  ButtonStyle.swift
//  DvdScreensaver
//
//  Created by rsbj on 02/11/22.
//

import SwiftUI

struct MyActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("DaysOne-Regular", size: 30))
            .foregroundColor(.white)
            .frame(height: 67)
            .frame(width: 140)
            .background(
                Image("button")
            )
    }
}
