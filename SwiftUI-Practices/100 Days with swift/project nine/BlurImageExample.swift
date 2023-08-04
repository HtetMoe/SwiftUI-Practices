//
//  BlurImageExample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 10/07/2023.
//

import SwiftUI

struct BlurImageExample: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack{
            Image("Example")
                .resizable()
                .scaledToFit()
                .frame(width: .infinity, height: 200)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
        
    }
}

struct BlurImageExample_Previews: PreviewProvider {
    static var previews: some View {
        BlurImageExample()
    }
}
