//
//  ShowHideTransactionAnimation.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 06/07/2023.
//

import SwiftUI

struct ShowHideTransactionAnimation: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
           
        }
    }
}

struct TransactionAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ShowHideTransactionAnimation()
    }
}
