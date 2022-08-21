//
//  ViewThatKnows.swift
//  LayoutTests
//
//  Created by carlynorama on 8/21/22.
//  https://swiftwithmajid.com/2020/01/15/the-magic-of-view-preferences-in-swiftui/
// https://www.fivestars.blog/articles/adaptive-swiftui-views/
// https://www.fivestars.blog/articles/swiftui-share-layout-information/


import SwiftUI

fileprivate struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct ViewThatKnows<Content:View>: View {
    let content:Content
    
    @Binding public var size:CGSize
    @Binding public var parentSize:CGSize
        
    public init(size:Binding<CGSize>, parentSize:Binding<CGSize>,
            @ViewBuilder _ Content: () -> Content
        ) {
        self.content = Content()
        self._size = size
        self._parentSize = parentSize
      }
    
    private var SizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }
    
    var body: some View {
        ZStack {
            Color.clear.background(            SizeView.onPreferenceChange(SizePreferenceKey.self, perform:onParentChange))
            content.background(
                SizeView.onPreferenceChange(SizePreferenceKey.self, perform:onChange)
            )
        }
    }
    
    func onChange(newSize:CGSize) {
        size = newSize
    }
    
    func onParentChange(newSize:CGSize) {
        parentSize = newSize
    }
}

fileprivate struct ViewForPreview:View {
    @State var size:CGSize = .zero
    @State var parent:CGSize = .zero
    var body: some View {
        VStack {
            Text("Extra view")
            ViewThatKnows(size: $size, parentSize: $parent){
                VStack {
                    Text("Hello I am \(size.width), \(size.height)").foregroundColor(.blue)
                    Text("My parent is \(parent.width), \(parent.height)").foregroundColor(.orange)
                }.border(.blue)
            }.layoutPriority(-1)//.frame(maxHeight: size.height*2)
            .border(.orange)
            Image(systemName:"globe").resizable().aspectRatio(contentMode: .fit)
        }
    }
}

struct ViewThatKnows_Previews: PreviewProvider {
    static var previews: some View {
        ViewForPreview()
    }
}

//
//fileprivate extension View {
//  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
//    background(
//      GeometryReader { geometryProxy in
//        Color.clear
//          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
//      }
//    )
//    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
//  }
//}
