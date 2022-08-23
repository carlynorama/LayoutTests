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


enum MyStyle:String, CaseIterable, Identifiable {
    case manualBlock
    case naiveVerticalBlock
    case compactVerticalBlock
    case fullWidth
    
    var id: Self { self }
}

struct WrappingLayout:Layout {
    //if this anchor is from .init(x,y) tje placesubviews does not pick it up?
    let anchor:UnitPoint
    let manualSize:CGSize// = CGSize(width: 50, height: 50)
    let style:MyStyle
    
    
    
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return sizeThatFits(subviews: subviews, proposal: proposal)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        
        let sizes = subviewProposedSizes(subviews: subviews)
        let offsets = subviewOffsets(sizes: sizes, bounds: bounds)
        
        for index in subviews.indices {
            let point:CGPoint = anchor.defaultOrigin(for: bounds)
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
    
    private func spacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .horizontal)
        }
    }
    
    func sizeThatFits(subviews:Subviews, proposal:ProposedViewSize) -> CGSize {
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
        case .fullWidth:
            return CGSize(width: manualSize.width, height: manualSize.height * CGFloat(subviews.count))
        }
    }
    
    func subviewProposedSizes(subviews:Subviews) -> [ProposedViewSize] {
        subviewCGSizes(subviews: subviews).map { ProposedViewSize($0) }
    }
    
    func subviewCGSizes(subviews:Subviews) -> [CGSize] {
        switch style {
        case .manualBlock:
            let sizes = [CGSize](repeating: manualSize, count: subviews.count)
            return sizes
        case .naiveVerticalBlock:
            let sizes = [CGSize](repeating: manualSize, count: subviews.count)
            return sizes
        case .compactVerticalBlock:
            let sizes = subviews.map {
                $0.sizeThatFits(.init(CGSize(
                    width: manualSize.width,
                    height: manualSize.height
                )))
              }
            return sizes
        case .fullWidth:
            let sizes = subviews.map {
                $0.sizeThatFits(.init(CGSize(
                    width: manualSize.width,
                    height: manualSize.height
                )))
              }
            return sizes
        }
    }
    
    func subviewOffsets(sizes:[ProposedViewSize], bounds:CGRect) -> [CGPoint] {
        switch style {
        case .manualBlock:
            let offsets = [CGPoint](repeating: anchor.defaultOrigin(for: bounds), count: sizes.count)
            return offsets
        case .naiveVerticalBlock:
            var offsets:[CGPoint] = []
            let base = bounds.origin
            //var next = CGPoint(x: 0, y: 0)
            for (index, size) in sizes.enumerated() {
                let localOffset = anchor.defaultOrigin(for: CGSize(width: size.width!, height: size.height!))
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
                let localOffset = anchor.defaultOrigin(for: CGSize(width: size.width!, height: size.height!))
                let x = base.x + localOffset.x
                let y = next.y + localOffset.y
                offsets.append(CGPoint(x:x, y:y))
                next.y =  next.y + size.height!
            }
            return offsets
        case .fullWidth:
            var offsets:[CGPoint] = []
        
            let base = bounds.origin
            var next = base
            for (size) in sizes {
                let localOffset = anchor.defaultOrigin(for: CGSize(width: size.width!, height: size.height!))
                let x = base.x + localOffset.x
                let y = next.y + localOffset.y
                offsets.append(CGPoint(x:x, y:y))
                next.y =  next.y + size.height!
            }
            return offsets
        }
    }
    
//    func sizes(subviews: Subviews) -> [CGSize] {
//        switch style {
//        case .manualBlock:
//            return [manualSize]
//        case .verticalBlock:
//            return [CGSize(width: manualSize.width, height: manualSize.height * CGFloat(subviews.count))]
//        }
//    }
}
