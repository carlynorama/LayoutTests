//
//  LayoutThatKnows.swift
//  LayoutTests
//
//  Created by Labtanza on 8/22/22.
//  https://talk.objc.io/episodes/S01E318-inspecting-swiftui-s-layout-process

import SwiftUI

extension View {
    func measure() -> some View {
        overlay(GeometryReader { proxy in
            Text("\(Int(proxy.size.width)) × \(Int(proxy.size.height))")
                .foregroundColor(.white)
                .background(.black)
                .font(.footnote)
        })
    }
    
    func logSizes(_ label:String) -> some View {
        LogSizes(label:label) { self }
        
    }
}

struct LogSizes:Layout {
    var label:String
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        assert(subviews.count == 1)
        print("\(label) proposed: \(proposal.pretty)")
        let result = subviews[0].sizeThatFits(proposal)
        //print("\(label): \n\tproposed - \(proposal.pretty) \n\tresult - \(result)")
        print("\(label) result: \(result.pretty)")
        return result
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        subviews[0].place(at: bounds.origin, proposal: proposal)
    }
    
    
}

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
