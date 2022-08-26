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

struct EHHStack: Layout {
    /// Returns a size that the layout container needs to arrange its subviews
    /// horizontally.
    /// - Tag: sizeThatFitsHorizontal
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout Void
    ) -> CGSize {
        guard !subviews.isEmpty else { return .zero }

        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)
        let totalSpacing = spacing.reduce(0) { $0 + $1 }

        return CGSize(
            width: maxSize.width * CGFloat(subviews.count) + totalSpacing,
            height: maxSize.height)
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

        let maxSize = maxSize(subviews: subviews)
        let spacing = spacing(subviews: subviews)

        var nextX = bounds.minX + maxSize.width / 2

        for index in subviews.indices {
            var width:CGFloat
            if subviews[index].priority > 0 {
                width = max(subviews[index].sizeThatFits(.unspecified).width, maxSize.height)
            } else {
                width = subviews[index].sizeThatFits(.unspecified).width
            }
            printInfo(subviews:subviews, index:index)
            subviews[index].place(
                at: CGPoint(x: nextX, y: bounds.midY),
                anchor: .center,
                proposal: ProposedViewSize(width: width, height: maxSize.height))
            nextX += width + spacing[index]
        }
    }

    /// Finds the largest ideal size of the subviews.
    private func maxSize(subviews: Subviews) -> CGSize {
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
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
