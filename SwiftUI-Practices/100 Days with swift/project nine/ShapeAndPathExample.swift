//
//  ShapeAndPathExample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 10/07/2023.
//

import SwiftUI

//triangle
struct Triangle : Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

//arc
struct Arc : InsettableShape {
    var startAngle : Angle
    var endAngle   : Angle
    var clockwise  : Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd   = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount , startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    /* arc doesn't support stroke border modifier, so adding stroke border to arc */
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ShapeAndPathExample: View {
    var body: some View {
        
        //triangle
//        Triangle()
//            //.fill(.red)
//            .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//            .frame(width: 300, height: 300)
        
        //arc
//        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
//            .stroke(.blue, lineWidth: 10)
//            .frame(width: 300, height: 300)
        
        //circle
//        Circle()
//            .strokeBorder(.blue, lineWidth: 3)
        
        //arc with stroke
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            .strokeBorder(.blue, lineWidth: 5)
            .frame(width: 300, height: 300)
        
    }
}

struct ShapeAndPathExample_Previews: PreviewProvider {
    static var previews: some View {
        ShapeAndPathExample()
    }
}
