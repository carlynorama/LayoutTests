//
//  ExtensionLayout+CommonTasks.swift
//  LayoutTests
//
//  Created by Labtanza on 8/22/22.
//  - https://developer.apple.com/videos/play/wwdc2022/10056/
//  - https://developer.apple.com/documentation/swiftui/composing_custom_layouts_with_swiftui

import Foundation
import SwiftUI


extension Layout {
    //what about returning the subview?
    
    func printInfo(subviews:Subviews, index:Int) {
        print("subview \(index):")
        print("size - \(subviews[index].sizeThatFits(.unspecified))")
        print("priority - \(subviews[index].priority)")
        print("spacing - \(subviews[index].spacing)")
        print("size at 1kx1k - \(subviews[index].dimensions(in: ProposedViewSize(width: 1000, height: 1000)))")
    }
    
    //TODO: Replace with Translate?
    func location(for local:CGPoint, in bounds:CGRect) -> CGPoint {
        let x = local.x + bounds.minX
        let y = local.y + bounds.minY
        return CGPoint(x: x,y: y)
    }
    
    func maxWidth(subviews: Subviews) -> CGFloat {
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let maxSize: CGFloat = subviewSizes.reduce(.zero) { currentMax, subviewSize in
            max(currentMax, subviewSize.width)
        }
            return maxSize
        }
    
    func maxHeight(subviews: Subviews) -> CGFloat {
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let maxSize: CGFloat = subviewSizes.reduce(.zero) { currentMax, subviewSize in
            max(currentMax, subviewSize.height)
        }
            return maxSize
        }

//    Relies on extension that supplies sumOfSquares to a CGSize
    // Does not use the the comparable extension to reduce the calls to sOS
//    static private func maxArea(subviews: Subviews) -> CGSize {
//        var currentMaxSubview = subviews[0]
//        var currentMaxDiagonal:CGFloat = currentMaxSubview.sizeThatFits(.unspecified).sumOfSquares()
//
//        for sv in subviews {
//            let svd = sv.sizeThatFits(.unspecified).sumOfSquares()
//            if  svd > currentMaxDiagonal {
//                currentMaxSubview = sv
//                currentMaxDiagonal = svd
//            }
//        }
//        return currentMaxSubview.sizeThatFits(.unspecified)
//        }
//
    /// Finds the largest ideal size of the subviews.
      func maxSize(subviews: Subviews) -> CGSize {
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
