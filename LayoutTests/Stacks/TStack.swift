//
//  AStack.swift
//  LayoutTests
//
//  Created by carlynorama on 8/21/22.

//extension CGSize {
//    var aspectRatio:CGFloat{
//        self.width / self.height
//    }
//}

import SwiftUI

struct TStack<Content:View>: View {
    //@Environment(\.horizontalSizeClass) private var size
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content:Content
    
    @State var size:CGSize = .zero
    @State var parentSize:CGSize = .zero
    
    //@Binding var threshold:CGFloat
     var threshold:CGFloat
    
    var aspectRatio:CGFloat {
        parentSize.aspectRatio
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
    
    var overThresold:Bool {
        parentSize.width > threshold
    }
    
    var body: some View {
        ViewThatKnows(size: $size, parentSize: $parentSize) {
            if #available(iOS 16.0, *) {
                buildNewStyleContent(overThresold)
            } else {
                buildOldStyleContent(overThresold)
            }
        }
        
        
    }
    
    @available(iOS 16.0, *)
    @ViewBuilder func buildNewStyleContent(_ passesThreshold:Bool) -> some View {
        let layout = (passesThreshold) ?
        AnyLayout(HStackLayout(alignment: verticalAlignment, spacing: spacing)) :
        AnyLayout(VStackLayout(alignment: horizontalAlignment, spacing: spacing))
        
        layout {
            content
        }
        .animation(.default, value: parentSize)
    }
    
    @ViewBuilder func buildOldStyleContent(_ passesThreshold:Bool) -> some View  {
        ZStack {
            if (passesThreshold) {
                HStack(alignment: verticalAlignment, spacing: spacing) { content }
            } else {
                VStack(alignment: horizontalAlignment, spacing: spacing) { content }
            }
        }.animation(.default, value: parentSize)
    }
    
    
}

//struct TStack_Previews: PreviewProvider {
//    static var previews: some View {
//        AStack() {
//            Text("Horizontal when its wide")
//            Text("but")
//            Text("Vertical when its narrow")
//        }
//    }
//}
