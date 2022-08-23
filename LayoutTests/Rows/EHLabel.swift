//
//  RowWithIcon.swift
//  LayoutTests
//
//  Created by Labtanza on 8/23/22.
//

import Foundation


/*
See LICENSE folder for this sample’s licensing information.
 (2022 WWDC Apple Sample Code)
 - https://developer.apple.com/videos/play/wwdc2022/10056/
 - https://developer.apple.com/documentation/swiftui/composing_custom_layouts_with_swiftui

Abstract:
A custom horizontal stack that offers all its subviews the width of its largest subview.
*/

//https://talk.objc.io/episodes/S01E308-the-layout-protocol

import SwiftUI

struct EHLabel: Layout {
    /// Returns a size that the layout container needs to arrange its subviews
    /// horizontally.
    /// - Tag: sizeThatFitsHorizontal
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) -> CGSize {
        guard !subviews.isEmpty else { return .zero }

        let maxSize = maxSize(subviews: subviews, proposal: proposal)
        let spacing = spacing(subviews: subviews)
        let desiredWidths = getDesiredWidths(for: subviews, with: maxSize.height, proposal: proposal)
        
        let totalSpacing = spacing.reduce(0) { $0 + $1 }
        let totalWidths = desiredWidths.reduce(0) { $0 + $1 }
        
        let containerWidth = totalSpacing + totalWidths
        
        return CGSize(width:containerWidth, height: maxSize.height)
    }

    /// Places the subviews in a horizontal stack.
    /// - Tag: placeSubviewsHorizontal
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) {
        guard !subviews.isEmpty else { return }

        let maxSize = maxSize(subviews: subviews, proposal: proposal)
        let spacing = spacing(subviews: subviews)
        let desiredWidths = getDesiredWidths(for: subviews, with: maxSize.height, proposal: proposal)
        
        
        var nextX = bounds.minX

        for index in subviews.indices {
            var width:CGFloat
            width = desiredWidths[index]
//            if subviews[index].priority >= 0 {
//                width = max(subviews[index].sizeThatFits(.unspecified).width, maxSize.height)
//            } else {
//                width = subviews[index].sizeThatFits(.unspecified).width
//            }
            printInfo(subviews:subviews, index:index)
            subviews[index].place(
                at: CGPoint(x: nextX, y: bounds.minY),
                proposal: ProposedViewSize(width: width, height: maxSize.height))
            nextX += width + spacing[index]
        }
    }
    
    private func getDesiredWidths(for subviews: Subviews, with height:CGFloat, proposal:ProposedViewSize) ->  [CGFloat] {
        var newWidths:[CGFloat] = []
        for index in subviews.indices {
            switch subviews[index].priority {
//            case let x where x < 0:
//                newWidths.append((max(subviews[index].sizeThatFits(styleForPriority(x, height: height, proposal:proposal)).width, height)))
            case let x where x == 0:
                newWidths.append((max(subviews[index].sizeThatFits(.unspecified).width, height)))
            case let x where x > 0:
                newWidths.append((max(subviews[index].sizeThatFits(styleForPriority(x, height: height, proposal:proposal)).width, height)))
            default:
                newWidths.append(subviews[index].sizeThatFits(.unspecified).width)
            }
        }
        return(newWidths)
    }
    
    private func styleForPriority(_ priority:Double, height:CGFloat = .zero, proposal:ProposedViewSize = .zero) -> ProposedViewSize {
        switch priority {
        case 10:
            return .infinity
        case -10:
            return .zero
        case let x where (5...10).contains(x):
            let factor = CGFloat(x) * 0.10
            let width = (proposal.width ?? 0)// * factor
            let height:CGFloat = proposal.height ?? .zero
            return .init(CGSize(width: width, height: height))
        case let x where x < -10:
            return .unspecified
        default:
            return .unspecified
        }
    }

    /// Finds the largest ideal size of the subviews.
    private func maxSize(subviews: Subviews, proposal:ProposedViewSize = .zero) -> CGSize {
        let subviewSizes = subviews.map { $0.sizeThatFits(styleForPriority($0.priority, proposal: proposal)) }
        let maxSize: CGSize = subviewSizes.reduce(.zero) { currentMax, subviewSize in
            CGSize(
                width: max(currentMax.width, subviewSize.width),
                height: max(currentMax.height, subviewSize.height))
        }

        return maxSize
    }

    /// Gets an array of preferred spacing sizes between subviews in the
    /// horizontal dimension.
    private func spacing(subviews: Subviews) -> [CGFloat] {
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(
                to: subviews[index + 1].spacing,
                along: .horizontal)
        }
    }
}
