//
//  AStack.swift
//  LayoutTests
//
//  Created by carlynorama on 8/21/22.

//https://www.swiftbysundell.com/articles/switching-between-swiftui-hstack-vstack/

//extension CGSize {
//    var aspectRatio:CGFloat{
//        self.width / self.height
//    }
//}

import SwiftUI

struct AStack2<Content:View>: View {
    //@Environment(\.horizontalSizeClass) private var size
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content:Content
    
    @State var size:CGSize = .zero
    @State var parentSize:CGSize = .zero
    
    @State var test:Bool = false
    
    
    public init(
        horizontalAlignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder _ Content: () -> Content
    ) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.content = Content()
    }
    
    var body: some View {
        ViewThatKnows(size: $size, parentSize: $parentSize) {
            ConditionalStackLayout(isHorizontal: $test, horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment, spacing: spacing) {
                content
            }
        }.onChange(of: parentSize) { newSize in
            test = newSize.aspectRatio > 1
        }
    }
    
}

struct AStack2_Previews: PreviewProvider {
    static var previews: some View {
        AStack2() {
            Text("Horizontal when its wide")
            Text("but")
            Text("Vertical when its narrow")
        }
    }
}
