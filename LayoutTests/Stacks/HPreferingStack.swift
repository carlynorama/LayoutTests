//
//  HPreferingStack.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
//

import SwiftUI

struct HPreferingStack<Content:View>: View {
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
        ViewThatFits {
            HStackLayout(
                alignment: verticalAlignment,
                spacing: spacing
            ) { content }

            VStackLayout(
                alignment: horizontalAlignment,
                spacing: spacing
            ) { content }
        }
    }
}

struct HPreferingStack_Previews: PreviewProvider {
    static var previews: some View {
        HPreferingStack {
            Text("Horizontal when its wide")
            Text("but")
            Text("Vertical when its narrow")
        }
    }
}
