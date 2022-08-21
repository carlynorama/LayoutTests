//
//  AStack.swift
//  LayoutTests
//
//  Created by carlynorama on 8/21/22.

//https://www.swiftbysundell.com/articles/switching-between-swiftui-hstack-vstack/


import SwiftUI

//An AStack but with ConditionalStackLayout underneath. 
struct AStack<Content:View>: View {
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content:Content
    
    @State var size:CGSize = .zero
    @State var parentSize:CGSize = .zero
    
    var test:Bool {
        parentSize.aspectRatio > 1
    }
    
    
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
            ConditionalStackLayout(isHorizontal: test, horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment, spacing: spacing) {
                content
            }
        }
    }
    
}

struct AStack_Previews: PreviewProvider {
    static var previews: some View {
        AStack() {
            Text("Horizontal when its wide")
            Text("but")
            Text("Vertical when its narrow")
        }
    }
}
