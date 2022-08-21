//
//  FStack.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
//

import SwiftUI

struct FStack<Content:View>: View {
    @Environment(\.horizontalSizeClass) private var size
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content:Content
        
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
        let layout = (size == .regular) ?
        AnyLayout(HStackLayout(alignment: verticalAlignment, spacing: spacing)) :
        AnyLayout(VStackLayout(alignment: horizontalAlignment, spacing: spacing))
        
        layout {
            content
        }
        .animation(.default, value: size)
    }
}

struct FStack_Previews: PreviewProvider {
    static var previews: some View {
        FStack(horizontalAlignment: .trailing, verticalAlignment: .center) {
            Text("Horizontal when there's lots of space")
            Text("but")
            Text("Vertical when space is restricted")
        }
    }
}
