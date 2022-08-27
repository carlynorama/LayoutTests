//
//  WrappingLayout.swift
//  LayoutTests
//
//  Created by Labtanza on 8/23/22.
//

import Foundation
import SwiftUI

//struct WrappingLayout:Layout {
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        return CGSize(width: 50, height: 50)
//    }
//
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        for index in subviews.indices {
//            subviews[index].place(
//                at: CGPoint(x: bounds.minX, y: bounds.minY),
//                proposal: proposal)
//        }
//    }
//
//}


enum MyStyle:String, CaseIterable, Identifiable, Equatable {
    case manualBlock
    case naiveVerticalBlock
    case compactVerticalBlock
    case naiveBoundingHeight
    case boundingHeight
    
    var id: Self { self }
    
    var usesCellHeight:Bool {
        switch self {
        case .manualBlock:
            return false
        case .naiveVerticalBlock:
            return true
        case .compactVerticalBlock:
            return true
        case .naiveBoundingHeight:
            return false
        case .boundingHeight:
            return false
        }
    }
}

struct VStackExperiments:Layout {
    //if this anchor is from .init(x,y) tje placesubviews does not pick it up?
    let anchor:UnitPoint
    let manualSize:CGSize// = CGSize(width: 50, height: 50)
    let style:MyStyle
    
    
    

    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout CacheData) {
        guard !subviews.isEmpty else { return }
        
        let sizes = subviewProposedSizes(subviews: subviews, proposal: proposal)
        let offsets = subviewOffsets(sizes: sizes, bounds: bounds)
        
        for index in subviews.indices {
            let point:CGPoint = anchor.anchorPoint(for: bounds)
            print("point recieved:\(point)")
            subviews[index].place(
                at: offsets[index],
                anchor: anchor, //does not seem to work for non predefined unit points
                proposal: sizes[index])
        }
        
//        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
//        let offsets = generateFlowLayout(sizes: sizes, containerWidth: bounds.width).offsets
//        for (offset, subview) in zip(offsets, subviews) {
//            subview.place(at: CGPoint(x: offset.x + bounds.minX, y: offset.y + bounds.minY), proposal: .unspecified)
//        }
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout CacheData) -> CGSize {
        switch style {
        case .manualBlock:
            return manualSize
        case .naiveVerticalBlock:
            return CGSize(width: manualSize.width, height: manualSize.height * CGFloat(subviews.count))
        case .compactVerticalBlock:
            let width = manualSize.width
            let height = manualSize.height
            let cgsizes = subviews.map {
                $0.sizeThatFits(.init(CGSize(width: width, height: height))).height
            }
            let heightSum:CGFloat = cgsizes.reduce(0) { $0 + $1  }
            return CGSize(width: manualSize.width, height: heightSum)
        case .naiveBoundingHeight:
            return CGSize(width: manualSize.width, height: manualSize.height)
        case .boundingHeight:
            let width = manualSize.width
            let height:CGFloat = proposal.height ?? manualSize.height/CGFloat(subviews.count)
            let cgsizes = subviews.map {
                $0.sizeThatFits(.init(CGSize(width: width, height: height)))
            }
            let maxwidth = (cgsizes.map { $0.width }).max() ?? proposal.width
            let heightSum:CGFloat = (cgsizes.map { $0.height }).reduce(0) { $0 + $1  }
            return CGSize(width: maxwidth ?? 0, height: heightSum)
        }
    }
    
    func subviewProposedSizes(subviews:Subviews, proposal:ProposedViewSize) -> [ProposedViewSize] {
        subviewCGSizes(subviews: subviews, proposal: proposal).map { ProposedViewSize($0) }
    }
    
    func subviewCGSizes(subviews:Subviews, proposal:ProposedViewSize) -> [CGSize] {
        switch style {
        case .manualBlock:
            let sizes = [CGSize](repeating: manualSize, count: subviews.count)
            return sizes
        case .naiveVerticalBlock:
            let sizes = [CGSize](repeating: manualSize, count: subviews.count)
            return sizes
        case .compactVerticalBlock:
//            let sizes = subviews.map {
//                $0.sizeThatFits(.init(CGSize(
//                    width: manualSize.width,
//                    height: manualSize.height
//                )))
//              }
//            return sizes
            let sizes = subviews.map {
                $0.sizeThatFits(.init(CGSize(
                    width: manualSize.width,
                    height: manualSize.height
                )))
              }
            return sizes.map { CGSize(width: manualSize.width, height: $0.height) }
            
        case .naiveBoundingHeight:
            
            let sizes = [CGSize](repeating: CGSize(width:manualSize.width, height: manualSize.height/CGFloat(subviews.count)), count: subviews.count)
//            let sizes = subviews.map {
//                $0.sizeThatFits(.init(CGSize(
//                    width: manualSize.width,
//                    height: manualSize.height/CGFloat(subviews.count)
//                )))
//              }
            return sizes//.map { CGSize(width: manualSize.width, height: $0.height) }
        case .boundingHeight:
            let width = manualSize.width
            let height:CGFloat = .infinity
            let sizes = subviews.map {
                $0.sizeThatFits(.init(CGSize(width: width, height: height)))
            }
            return sizes//.map { CGSize(width: manualSize.width, height: $0.height) }
        }
    }
    
    func subviewOffsets(sizes:[ProposedViewSize], bounds:CGRect) -> [CGPoint] {
        switch style {
        case .manualBlock:
            let offsets = [CGPoint](repeating: anchor.anchorPoint(for: bounds), count: sizes.count)
            return offsets
        case .naiveVerticalBlock:
            var offsets:[CGPoint] = []
            let base = bounds.origin
            //var next = CGPoint(x: 0, y: 0)
            for (index, size) in sizes.enumerated() {
                let localOffset = anchor.anchorPoint(for: CGSize(width: size.width!, height: size.height!))
                let x = base.x + localOffset.x
                let y = base.y + (CGFloat(index) * size.height!) + localOffset.y
                offsets.append(CGPoint(x:x, y:y))
            }
            return offsets
        case .compactVerticalBlock:
            var offsets:[CGPoint] = []
        
            let base = bounds.origin
            var next = base
            for (size) in sizes {
                let localOffset = anchor.anchorPoint(for: CGSize(width: size.width!, height: size.height!))
                let x = base.x + localOffset.x
                let y = next.y + localOffset.y
                offsets.append(CGPoint(x:x, y:y))
                next.y =  next.y + size.height!
            }
            return offsets
        case .naiveBoundingHeight:
            var offsets:[CGPoint] = []
        
            let base = bounds.origin
            var next = base
            for (size) in sizes {
                let localOffset = anchor.anchorPoint(for: CGSize(width: size.width!, height: size.height!))
                let x = base.x + localOffset.x
                let y = next.y + localOffset.y
                offsets.append(CGPoint(x:x, y:y))
                next.y =  next.y + size.height!
            }
            return offsets
        case .boundingHeight:
            var offsets:[CGPoint] = []
        
            let base = bounds.origin
            var next = base
            for (size) in sizes {
                let localOffset = anchor.anchorPoint(for: CGSize(width: size.width ?? 0, height: size.height ?? 0))
                let x = base.x + localOffset.x
                let y = next.y + localOffset.y
                offsets.append(CGPoint(x:x, y:y))
                next.y =  next.y + (size.height ?? 0)
            }
            return offsets
        }
    }
    
    struct CacheData {
        //let maxSize: CGSize
        let spacing: [CGFloat]
        let totalSpacing: CGFloat
    }

    /// Creates a cache for a given set of subviews.
    ///
    /// When the subviews change, SwiftUI calls the ``updateCache(_:subviews:)``
    /// method. The ``MyEqualWidthVStack`` layout relies on the default
    /// implementation of that method, which just calls this method again
    /// to recreate the cache.
    /// - Tag: makeCache
    func makeCache(subviews: Subviews) -> CacheData {
        //let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }

        return CacheData(
            //maxSize: maxSize,
            spacing: spacing,
            totalSpacing: totalSpacing)
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
