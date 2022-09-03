//
//  TabDesign.swift
//  LayoutTests
//
//  Created by Labtanza on 8/31/22.
//

import SwiftUI

struct TabDesign: View {
    @State var visibilityToggle = true
    
    var width:CGFloat = 80
    var height:Double {
        width * 2.0
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabShape(width: 80).padding()
            Image(systemName: "square").foregroundColor(.accentColor)
        }.frame(width: width, height: height)
    }
}
fileprivate struct TabShape: Shape {
    var width:CGFloat
    var height:Double {
        width * 2.0
    }
    
    var cornerVar: Double {
        height*0.5
    }
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: rect.origin)
            path.addLine(to: CGPoint(x: rect.origin.x + width, y: rect.origin.y))
            path.addLine(to: CGPoint(x: rect.origin.x + width, y: rect.origin.y + height))
            path.addLine(to: CGPoint(x: rect.origin.x + width/2, y: rect.origin.y + height))
           // addArc(center:radius:startAngle:endAngle:clockwise:)
            path.addQuadCurve(to: CGPoint(x: rect.origin.x, y: rect.origin.y + height-(width/2)), control: CGPoint(x: rect.origin.x, y: rect.origin.y + height))
            path.addLine(to: rect.origin)
            path.closeSubpath()
        }
    }
}

struct ArcShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addArc(tangent1End: CGPoint(x: 100, y: 150),
                        tangent2End: CGPoint(x: 300, y: 50),
                        radius: 100,
                        transform: CGAffineTransform(scaleX: 0.9, y: 1.1))
            path.move(to: CGPoint(x: 100, y: 150))
           // path.ad
        }
    }
}
    
    struct TabDesign_Previews: PreviewProvider {
        static var previews: some View {
            TabDesign()
        }
    }
