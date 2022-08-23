//
//  EnumSwitcher.swift
//  LayoutTests
//
//  Created by Labtanza on 8/22/22.
//  https://talk.objc.io/episodes/S01E308-the-layout-protocol

// to Layout are Grid and _Circle.

import SwiftUI

enum Algo: String, CaseIterable, Identifiable {
    case vstack
    case hstack
    case zstack
    case flow
    //case circle
    
    var layout: any Layout {
        switch self {
        case .vstack: return VStackLayout()
        case .hstack: return HStackLayout()
        case .zstack: return ZStackLayout()
        case .flow: return FlowLayout()
        //case .circle: return _CircleLayout(radius: 200)
        }
    }
    
    var id: Self { self }
}

struct FlowSwitcher: View {
    @State var algo = Algo.hstack
        
        var body: some View {
            VStack {
                Picker("Algorithm", selection: $algo) {
                    ForEach(Algo.allCases) { algo in
                        Text("\(algo.rawValue)")
                    }
                }
                .pickerStyle(.segmented)
                let layout = AnyLayout(algo.layout)
                layout {
                    ForEach(0..<5) { ix in
                        Text("Really really really really really really really long name in the item Item \(ix)")
                            .padding()
                            .background(Capsule()
                                .fill(Color(hue: .init(ix)/10, saturation: 0.8, brightness: 0.8)))
                    }
                }
                .animation(.default, value: algo)
                .frame(maxHeight: .infinity)
            }
    }
}

func generateFlowLayout(sizes: [CGSize], spacing: CGFloat = 10, containerWidth: CGFloat) -> (offsets: [CGPoint], size: CGSize) {
    var result: [CGPoint] = []
    var currentPosition: CGPoint = .zero
    var lineHeight: CGFloat = 0
    var maxX: CGFloat = 0
    for size in sizes {
        if currentPosition.x + size.width > containerWidth {
            currentPosition.x = 0
            currentPosition.y += lineHeight + spacing
            lineHeight = 0
        }
        
        result.append(currentPosition)
        currentPosition.x += size.width
        maxX = max(maxX, currentPosition.x)
        currentPosition.x += spacing
        lineHeight = max(lineHeight, size.height)
    }
    
    return (result, CGSize(width: maxX, height: currentPosition.y + lineHeight))
}

struct FlowLayout:Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let containerWidth = proposal.replacingUnspecifiedDimensions().width
        let sizes = subviews.map  { $0.sizeThatFits(.unspecified) }
        print(proposal.replacingUnspecifiedDimensions())
        
        return generateFlowLayout(sizes: sizes, containerWidth: containerWidth).size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let offsets = generateFlowLayout(sizes: sizes, containerWidth: bounds.width).offsets
        for (offset, subview) in zip(offsets, subviews) {
            subview.place(at: CGPoint(x: offset.x + bounds.minX, y: offset.y + bounds.minY), proposal: .unspecified)
        }
    }
    

    
}

struct EnumSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        FlowSwitcher()
    }
}
