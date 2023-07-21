//
//  TappableView.swift
//  DvdScreensaver
//
//  Created by jpbol on 31/10/2022.
//

import Foundation
import SwiftUI

struct TappableView: UIViewRepresentable
{
    var tapCallback: (UITapGestureRecognizer) -> Void

    typealias UIViewType = UIView

    func makeCoordinator() -> TappableView.Coordinator
    {
        Coordinator(tapCallback: self.tapCallback)
    }

    func makeUIView(context: Self.Context) -> UIView
    {
        let view = UIView()
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(sender:)))
       
        /// Set number of touches.
        doubleTapGestureRecognizer.numberOfTouchesRequired = 2
       
        view.addGestureRecognizer(doubleTapGestureRecognizer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Self.Context)
    {
    }

    class Coordinator
    {
        var tapCallback: (UITapGestureRecognizer) -> Void

        init(tapCallback: @escaping (UITapGestureRecognizer) -> Void)
        {
            self.tapCallback = tapCallback
        }

        @objc func handleTap(sender: UITapGestureRecognizer)
        {
            self.tapCallback(sender)
        }
    }
}
