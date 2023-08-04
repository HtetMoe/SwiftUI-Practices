//
//  FloatingAnimation.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 06/07/2023.
//

import SwiftUI

struct FloatingAnimation: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
    
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),value: animationAmount)
        )
        .onAppear {
            animationAmount = 2
        }
    }
}

struct FloatingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        FloatingAnimation()
    }
}
