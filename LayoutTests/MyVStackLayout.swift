//
//  MyVStackLayout.swift
//  LayoutTests
//
//  Created by Labtanza on 8/26/22.
//

import SwiftUI


struct MyVStackLayout:Layout {
    let anchor:UnitPoint
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout CacheData) -> CGSize {
        let sizes = layout(proposed: proposal, subviews: subviews)
        let width:CGFloat = sizes.reduce(0) { max($0, $1.width) }
        let height:CGFloat = sizes.reduce(0) { $0 + $1.height }
        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CacheData) {
        guard !subviews.isEmpty else { return }
        
        let newSizes = layout(proposed: proposal, subviews: subviews)
        let offsets = subviewOffsets(sizes: newSizes, bounds: bounds)
        
        for index in subviews.indices {
            let point:CGPoint = anchor.defaultOrigin(for: bounds)
            print("point recieved:\(point)")
            subviews[index].place(
                at: offsets[index],
                anchor: anchor, //does not seem to work for non predefined unit points
                proposal: ProposedViewSize(newSizes[index]))
        }
    }
    
    
    
    
//    func subviewCGSizes(subviews:Subviews, size:CGSize) -> [CGSize] {
//        let sizes = subviews.map {
//            $0.sizeThatFits(.init(CGSize(
//                width: size.width,
//                height: size.height
//            )))
//          }
//        return sizes//.map { CGSize(width: manualSize.width, height: $0.height) }
//    }
    
    func subviewOffsets(sizes:[CGSize], bounds:CGRect) -> [CGPoint] {
        var offsets:[CGPoint] = []
    
        let base = bounds.origin
        var next = base
        for (size) in sizes {
            let localOffset = anchor.defaultOrigin(for: CGSize(width: size.width, height: size.height))
            let x = base.x + localOffset.x
            let y = next.y + localOffset.y
            offsets.append(CGPoint(x:x, y:y))
            next.y =  next.y + size.height
        }
        return offsets
    }
    
    func layout(proposed: ProposedViewSize, subviews children:Subviews) -> [CGSize] {
        let flexibility: [LayoutInfo] = LayoutInfo.retrieve(for: children , with: proposed)
        var groups = flexibility.group(by: \.priority)
        var sizes: [CGSize] = Array(repeating: .zero, count: children.count)
        let allMinHeights = flexibility.map(\.lowerH).reduce(0,+)
        var remainingHeight = proposed.height! - allMinHeights // TODO force unwrap
        
        while !groups.isEmpty {
            let group = groups.removeFirst()
            remainingHeight += group.map(\.lowerH).reduce(0,+)
            
            var remainingIndices = group.map { $0.index }
            while !remainingIndices.isEmpty {
                let height = allMinHeights / CGFloat(remainingIndices.count)
                let idx = remainingIndices.removeFirst()
                let child = children[idx]
                let size = child.sizeThatFits(ProposedViewSize(width: proposed.width, height: height))
                sizes[idx] = size
                remainingHeight -= size.height
                if remainingHeight < 0 { remainingHeight = 0 }
            }
        }
        return sizes
    }
    
    

    /// A type that stores cached data.
    /// - Tag: CacheData
    struct CacheData {
        let spacing: [CGFloat]
        let totalSpacing: CGFloat
    }

    /// Creates a cache for a given set of subviews.
    ///
    func makeCache(subviews: Subviews) -> CacheData {
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }

        return CacheData(
            spacing: spacing,
            totalSpacing: totalSpacing
        )
    }
    
    private func spacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .horizontal)
        }
    }
}
