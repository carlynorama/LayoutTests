//
//  AStack.swift
//  LayoutTests
//
//  Created by carlynorama on 8/21/22.
//  https://www.fivestars.blog/articles/adaptive-swiftui-views/
//https://www.swiftbysundell.com/articles/switching-between-swiftui-hstack-vstack/

extension CGSize {
    var aspectRatio:CGFloat{
        self.width / self.height
    }
}



import SwiftUI

struct AStack<Content:View>: View {
    @Environment(\.horizontalSizeClass) private var size
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let threshold:CGFloat?
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
            self.threshold = nil
      }
    
    var body: some View {
        GeometryReader { proxy in
            if #available(iOS 16.0, *) {
                buildNewStyleContent(for:proxy)
            } else {
                buildOldStyleContent(for:proxy)
            }
        }
    }
    
    @available(iOS 16.0, *)
    @ViewBuilder func buildNewStyleContent(for proxy:GeometryProxy) -> some View {
        let layout = (proxy.size.aspectRatio > 1) ?
        AnyLayout(HStackLayout(alignment: verticalAlignment, spacing: spacing)) :
        AnyLayout(VStackLayout(alignment: horizontalAlignment, spacing: spacing))
        
        layout {
            content
        }
        .animation(.default, value: size)
    }
    
    @ViewBuilder func buildOldStyleContent(for proxy:GeometryProxy) -> some View  {
        ZStack {
            if (proxy.size.aspectRatio > 1) {
                VStack(alignment: horizontalAlignment, spacing: spacing) { content }
            } else {
                HStack(alignment: verticalAlignment, spacing: spacing) { content }
            }
        }.animation(.default, value: size)
    }
    

    
}

struct AStack_Previews: PreviewProvider {
    static var previews: some View {
        AStack() {
            Text("Horizontal when there's lots of space")
            Text("but")
            Text("Vertical when space is restricted")
        }
    }
}
