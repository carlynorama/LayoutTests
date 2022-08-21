//
//  ConditionalLayout.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
//  https://www.swiftbysundell.com/articles/switching-between-swiftui-hstack-vstack/

import SwiftUI

struct ConditionalStackLayout<Content:View>: View {
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content:Content
    
    var test:Bool
    
    public init(
        isHorizontal:Bool,
        horizontalAlignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder _ Content: () -> Content
    ) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.content = Content()
        self.test = isHorizontal
    }
    
    var body: some View {
            if #available(iOS 16.0, *) {
                buildNewStyleContent(test)
            } else {
                buildOldStyleContent(test)
            }
    }
    
    //Am I loosing the identity preservation by putting these in a viewbuilder func?
    @available(iOS 16.0, *)
    @ViewBuilder func buildNewStyleContent(_ test:Bool) -> some View {
        let layout = (test) ?
        AnyLayout(HStackLayout(alignment: verticalAlignment, spacing: spacing)) :
        AnyLayout(VStackLayout(alignment: horizontalAlignment, spacing: spacing))
        
        layout {
            content
        }
        .animation(.default, value: test)
    }
    
    @ViewBuilder func buildOldStyleContent(_ test:Bool) -> some View  {
        ZStack {
            if (test) {
                HStack(alignment: verticalAlignment, spacing: spacing) { content }
            } else {
                VStack(alignment: horizontalAlignment, spacing: spacing) { content }
            }
        }.animation(.default, value: test)
    }
    
    
}

struct ConditionalLayout_Previews: PreviewProvider {
    static var previews: some View {
            AStack() {
                Text("Horizontal when its wide")
                Text("but")
                Text("Vertical when its narrow")
            }
    }
}
