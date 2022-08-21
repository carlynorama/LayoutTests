//
//  AStack.swift
//  LayoutTests
//
//  Created by carlynorama on 8/21/22.

//https://www.swiftbysundell.com/articles/switching-between-swiftui-hstack-vstack/

extension CGSize {
    var aspectRatio:CGFloat{
        self.width / self.height
    }
}

import SwiftUI

struct AStack<Content:View>: View {
    //@Environment(\.horizontalSizeClass) private var size
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content:Content
    
    @State var size:CGSize = .zero
    @State var parentSize:CGSize = .zero
    
    var aspectRatio:CGFloat {
        parentSize.aspectRatio
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
            if #available(iOS 16.0, *) {
                buildNewStyleContent(with:aspectRatio)
            } else {
                buildOldStyleContent(with:aspectRatio)
            }
        }
    }
    
    @available(iOS 16.0, *)
    @ViewBuilder func buildNewStyleContent(with ratio:CGFloat) -> some View {
        let layout = (ratio > 1) ?
        AnyLayout(HStackLayout(alignment: verticalAlignment, spacing: spacing)) :
        AnyLayout(VStackLayout(alignment: horizontalAlignment, spacing: spacing))
        
        layout {
            content
        }
        .animation(.default, value: parentSize)
    }
    
    @ViewBuilder func buildOldStyleContent(with ratio:CGFloat) -> some View  {
        ZStack {
            if (ratio > 1) {
                HStack(alignment: verticalAlignment, spacing: spacing) { content }
                
            } else {
                VStack(alignment: horizontalAlignment, spacing: spacing) { content }
            }
        }.animation(.default, value: parentSize)
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
