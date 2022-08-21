//
//  FStack.swift
//  LayoutTests
//
//  Created by carlynorama on 8/21/22.


import SwiftUI

//An FStack but with ConditionalStackLayout underneath.
struct FStack<Content:View>: View {
    @Environment(\.horizontalSizeClass) private var size
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content:Content
    
    var test:Bool {
        size != .compact // vs (size == .regular) ?
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
            ConditionalStackLayout(isHorizontal: test, horizontalAlignment: horizontalAlignment, verticalAlignment: verticalAlignment, spacing: spacing) {
                content
            }
    }
    
}

struct FStack_Previews: PreviewProvider {
    static var previews: some View {
        FStack() {
            Text("Horizontal when its wide")
            Text("but")
            Text("Vertical when its narrow")
        }
    }
}
