//
//  ImagePaintExample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 10/07/2023.
//

import SwiftUI

struct ImagePaintExample: View {
    var body: some View {
        
        Capsule()
            //.border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
            .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 40)
            .frame(width: 300, height: 200)
    }
}

struct ImagePaintExample_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaintExample()
    }
}
