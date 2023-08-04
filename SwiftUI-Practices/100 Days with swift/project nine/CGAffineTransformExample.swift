//
//  CGAffineTransformExample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 10/07/2023.
//

import SwiftUI

//Flower shape
struct Flower : Shape{
    var petalOffset: Double = -20 // petal away from center
    var petalWidth: Double = 100 // wide of each petal
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct CGAffineTransformExample: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(.red, style: FillStyle(eoFill: true))
                //.fill(.red)
                //.stroke(.red, lineWidth: 1)
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct CGAffineTransformExample_Previews: PreviewProvider {
    static var previews: some View {
        CGAffineTransformExample()
    }
}
