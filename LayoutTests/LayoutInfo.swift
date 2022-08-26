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
struct LayoutInfo {
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

            let lower = child.sizeThatFits(ProposedViewSize(width: 0, height: proposed.height)).width
            let upper = child.sizeThatFits(ProposedViewSize(width: .greatestFiniteMagnitude, height: proposed.height)).width
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
        if lhs.widthFlexibility < rhs.widthFlexibility { return true }
        return false
    }
    
    
    var isFixed: Bool {
        lowerH == upperH
    }
    
    
    var widthFlexibility:CGFloat {
        upperH - lowerH
    }
    
}
