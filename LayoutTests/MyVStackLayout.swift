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
        layout(proposed: proposal, subviews: subviews, cache: &cache)
        let width:CGFloat = cache.sizes.reduce(0) { max($0, $1.width) }
        let height:CGFloat = cache.sizes.reduce(0) { $0 + $1.height }
        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CacheData) {
        guard !subviews.isEmpty else { return }
        
        let offsets = subviewOffsets(sizes: cache.sizes, bounds: bounds)
        
        for index in subviews.indices {
            let point:CGPoint = anchor.defaultOrigin(for: bounds)
            print("point recieved:\(point)")
            subviews[index].place(
                at: offsets[index],
                anchor: anchor, //does not seem to work for non predefined unit points
                proposal: ProposedViewSize(cache.sizes[index]))
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
    
    func layout(proposed: ProposedViewSize, subviews children:Subviews, cache: inout CacheData) {
        let flexibility: [LayoutInfo] = LayoutInfo.retrieve(for: children , with: proposed)
        var groups = flexibility.group(by: \.priority)
        var sizes: [CGSize] = Array(repeating: .zero, count: children.count)
        let allMinWidths = flexibility.map(\.lowerH).reduce(0,+)
        var remainingWidth = proposed.width! - allMinWidths // TODO force unwrap
        
        while !groups.isEmpty {
            let group = groups.removeFirst()
            remainingWidth += group.map(\.lowerH).reduce(0,+)
            
            var remainingIndices = group.map { $0.index }
            while !remainingIndices.isEmpty {
                let width = remainingWidth / CGFloat(remainingIndices.count)
                let idx = remainingIndices.removeFirst()
                let child = children[idx]
                let size = child.sizeThatFits(ProposedViewSize(width: width, height: proposed.height))
                sizes[idx] = size
                remainingWidth -= size.width
                if remainingWidth < 0 { remainingWidth = 0 }
            }
        }
       cache.sizes = sizes
    }
    
    

    /// A type that stores cached data.
    /// - Tag: CacheData
    struct CacheData {
        let spacing: [CGFloat]
        let totalSpacing: CGFloat
        var sizes:[CGSize]
        //let sizes: [CGSize]
    }

    /// Creates a cache for a given set of subviews.
    ///
    func makeCache(subviews: Subviews) -> CacheData {
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }
        var sizes:[CGSize] = []

        return CacheData(
            spacing: spacing,
            totalSpacing: totalSpacing,
            sizes: sizes
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
