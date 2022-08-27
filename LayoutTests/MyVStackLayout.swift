//
//  MyVStackLayout.swift
//  LayoutTests
//
//  Created by Labtanza on 8/26/22.
//

import SwiftUI


struct MyVStackLayout:Layout {
    var alignment:HorizontalAlignment = .center
    let spacing:CGFloat = 10
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout CacheData) -> CGSize {
        
        generateLayoutInfo(proposal: proposal, subviews: subviews, cache: &cache)

        return CGSize(width: cache.width, height: cache.height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CacheData) {
        guard !subviews.isEmpty else { return }
        
        let offsets = subviewOffsets(sizes: cache.sizes, spacings: cache.spacing, bounds: bounds, alignment: alignment)
        
        for index in subviews.indices {
            subviews[index].place(
                at: offsets[index],
                proposal: ProposedViewSize(cache.sizes[index]))
        }
    }
    
    
    func subviewOffsets(sizes:[CGSize], spacings:[CGFloat], bounds:CGRect, alignment:HorizontalAlignment) -> [CGPoint] {
        var offsets:[CGPoint] = []
        
        let pairs = zip(sizes, spacings)
    
        let base = bounds.anchorForAlignment(horizontal: alignment)
        var next = base
        for (pair) in pairs {
            let size = pair.0
            let spacing = pair.1
            let localOffset = size.anchorForAlignment(horizontal: alignment)
            let x = base.x - localOffset.x
            let y = next.y - localOffset.y
            offsets.append(CGPoint(x:x, y:y))
            next.y =  next.y + size.height + spacing
        }
        return offsets
    }
    
    
    func generateLayoutInfo(proposal: ProposedViewSize, subviews:Subviews, cache: inout CacheData) {
        let layoutProfiles: [LayoutInfo] = LayoutInfo.retrieve(for: subviews , with: proposal)
        cache.groups = layoutProfiles.group(by: \.priority)
        cache.allMinHeights = layoutProfiles.map(\.lowerH).reduce(0,+)
        cache.sizes = generateSizes(proposal: proposal, subviews: subviews, cache: &cache)
        cache.width = cache.sizes.reduce(0) { max($0, $1.width) }
        cache.height = cache.sizes.reduce(0) { $0 + $1.height }  + cache.totalSpacing
    }
    
    func generateSizes(proposal: ProposedViewSize, subviews:Subviews, cache: inout CacheData) -> [CGSize] {
        var sizes: [CGSize] = Array(repeating: .zero, count: subviews.count)
        var remainingHeight = proposal.height! - cache.allMinHeights - cache.totalSpacing// TODO force unwrap
        
        var localGroups = cache.groups
        
        while !localGroups.isEmpty {
            let group = localGroups.removeFirst()
            remainingHeight += group.map(\.lowerH).reduce(0,+)
            
            var remainingIndices = group.map { $0.index }
            while !remainingIndices.isEmpty {
                let height = remainingHeight / CGFloat(remainingIndices.count)
                let index = remainingIndices.removeFirst()
                let child = subviews[index]
                let size = child.sizeThatFits(ProposedViewSize(width: proposal.width, height: height))
                sizes[index] = size
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
        var groups:[[LayoutInfo]]
        var sizes:[CGSize]
        var allMinHeights:CGFloat
        var width:CGFloat
        var height:CGFloat
    }

    /// Creates a cache for a given set of subviews.
    ///
    func makeCache(subviews: Subviews) -> CacheData {
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }
        let groups:[[LayoutInfo]] = []
        let allMinHeights:CGFloat = 0
        let sizes:[CGSize] = []
        let width:CGFloat = 0
        let height:CGFloat = 0

        return CacheData(
            spacing: spacing,
            totalSpacing: totalSpacing,
            groups: groups,
            sizes: sizes,
            allMinHeights:allMinHeights,
            width: width,
            height: height
        )
    }
    
    private func spacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .vertical)
        }
    }
}
