//
//  ConditionalLayout.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
//

import SwiftUI

struct ConditionalStackLayout<Content:View>: View {
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content:Content
    
    //As binding or not?? pros cons?
    @Binding var test:Bool
    //var test:Bool
    
    public init(
        isHorizontal:Binding<Bool>,
        horizontalAlignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        @ViewBuilder _ Content: () -> Content
    ) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.content = Content()
        self._test = isHorizontal
    }
    
    var body: some View {
            if #available(iOS 16.0, *) {
                buildNewStyleContent(test)
            } else {
                buildOldStyleContent(test)
            }
    }
    
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
            AStack2() {
                Text("Horizontal when its wide")
                Text("but")
                Text("Vertical when its narrow")
            }
    }
}