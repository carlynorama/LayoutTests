//
//  LayoutThatKnows.swift
//  LayoutTests
//
//  Created by Labtanza on 8/22/22.
//  https://talk.objc.io/episodes/S01E318-inspecting-swiftui-s-layout-process

import SwiftUI



struct LayoutThatKnowsTestView: View {
    @State var proposedSize: CGSize = CGSize(width: 100, height: 100)
    var body: some View {
        VStack {
            Text("Hello, world!")
                .border(Color.red)
            //.measure()
                .logSizes("TextView")
                .padding(10)
                .logSizes("Padding")
                .background {
                    Color.orange
                        .frame(width: 200, height: 200)
                        .logSizes("Orange")
                }
                .logSizes("Background")
                .frame(width: proposedSize.width, height: proposedSize.height)
                .border(Color.green)
            Slider(value: $proposedSize.width, in: 0...300, label: { Text("Width")})
        }
    }
    
}

struct LayoutThatKnowsTestView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutThatKnowsTestView()
    }
}
