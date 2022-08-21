//
//  AStack.swift
//  LayoutTests
//
//  Created by carlynorama on 8/21/22.


import SwiftUI

//A TStack but with ConditionalStackLayout underneath.
struct TStack<Content:View>: View {
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content:Content
    
    @State var size:CGSize = .zero
    @State var parentSize:CGSize = .zero

     var threshold:CGFloat
    
    var test:Bool {
        parentSize.width > threshold
    }
    
    public init(threshold:CGFloat,
        horizontalAlignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder _ Content: () -> Content
    ) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.content = Content()
        self.threshold = threshold
    }
    
    var body: some View {
        ViewThatKnows(size: $size, parentSize: $parentSize) {
            ConditionalStackLayout(isHorizontal: test, horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment, spacing: spacing) {
                content
            }
        }
    }
    
}

struct TStack_Previews: PreviewProvider {
    static var previews: some View {
        TStack(threshold: 390) {
            Text("Horizontal when its wide")
            Text("but")
            Text("Vertical when its narrow")
        }
    }
}
