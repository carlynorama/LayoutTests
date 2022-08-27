////
////  LayoutInfo.swift
////  objc_ViewSystem
////
////  Created by Labtanza on 8/26/22.
////
//
//import Foundation
import SwiftUI
//
//
////--------------------
////MARK: LayoutState - i.e. Cache
////use this to avoid mutating the struct itself.
////@propertyWrapper
////final class LayoutState<A> {
////    var wrappedValue: A
////    init(wrappedValue: A) {
////        self.wrappedValue = wrappedValue
////    }
////}
//

//TODO: Repalce with
/*
 https://developer.apple.com/documentation/swiftui/layoutvaluekey
 https://developer.apple.com/documentation/swiftui/view/layoutvalue(key:value:)
 */
struct LayoutInfo {
    static let inf = 1e15
    
    var index: Int
    var lowerH: CGFloat
    var upperH: CGFloat
    var priority: Double
}
//
//
extension LayoutInfo {
    static func retrieve(for subviews:LayoutSubviews, with proposed:ProposedViewSize) -> [Self] {
        subviews.indices.map { idx in
            let child = subviews[idx]

            let lower = child.sizeThatFits(ProposedViewSize(width: proposed.width, height: 0)).height
            let upper = child.sizeThatFits(ProposedViewSize(width: proposed.width, height: inf)).height
            return LayoutInfo(
                index: idx,
                lowerH: lower,
                upperH: upper,
                priority: child.priority
            )
        }.sorted()
    }
}


extension LayoutInfo: Comparable {
    static func < (lhs: LayoutInfo, rhs: LayoutInfo) -> Bool {
        if lhs.priority > rhs.priority { return true }
        if lhs.priority < rhs.priority { return false }
        if lhs.heightFlexibility < rhs.heightFlexibility { return true }
        return false
    }
    
    
    var isFixed: Bool {
        lowerH == upperH
    }
    
    
    var heightFlexibility:CGFloat {
        upperH - lowerH
    }
    
}
