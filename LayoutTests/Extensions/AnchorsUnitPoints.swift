//
//  AnchorsUnitPoints.swift
//  LayoutTests
//
//  Created by Labtanza on 8/23/22.
//

import Foundation
import SwiftUI


extension UnitPoint {
    func defaultOrigin(for bounds: CGRect) -> CGPoint {
        switch self {
        case .center:
            return CGPoint(x: bounds.midX, y: bounds.midY)
        case .zero:
            return CGPoint(x: bounds.minX, y: bounds.minY)
        case .leading:
            return CGPoint(x: bounds.minX, y: bounds.midY)
        case .top:
            return CGPoint(x: bounds.midX, y: bounds.minY)
        case .topLeading:
            return CGPoint(x: bounds.minX, y: bounds.minY)
        case .topTrailing:
            return CGPoint(x: bounds.maxX, y: bounds.minY)
        case .bottom:
            return CGPoint(x: bounds.midX, y: bounds.maxY)
        case .bottomLeading:
            return CGPoint(x: bounds.minX, y: bounds.maxY)
        case .bottomTrailing:
            return CGPoint(x: bounds.maxX, y: bounds.maxY)
        case .trailing:
            return CGPoint(x: bounds.maxX, y: bounds.midY)
        default:
            return bounds.offsetBy(dx: self.x, dy: self.y).origin

        }
    }
    
    func defaultOrigin(for size: CGSize) -> CGPoint {
        switch self {
        case .center:
            return CGPoint(x: size.midX, y: size.midY)
        case .zero:
            return CGPoint(x: size.minX, y: size.minY)
        case .leading:
            return CGPoint(x: size.minX, y: size.midY)
        case .top:
            return CGPoint(x: size.midX, y: size.minY)
        case .topLeading:
            return CGPoint(x: size.minX, y: size.minY)
        case .topTrailing:
            return CGPoint(x: size.maxX, y: size.minY)
        case .bottom:
            return CGPoint(x: size.midX, y: size.maxY)
        case .bottomLeading:
            return CGPoint(x: size.minX, y: size.maxY)
        case .bottomTrailing:
            return CGPoint(x: size.maxX, y: size.maxY)
        case .trailing:
            return CGPoint(x: size.maxX, y: size.midY)
        default:
            return CGPoint(x: size.minX, y: size.minY)

        }
    }
    
    static var selectable:[(item:Self, menuText:String)] {
        return[
            (.center, "center"),
            (.zero, "zero"),
            (.leading, "leading"),
            (.top, "top"),
            (.topLeading, "topLeading"),
            (.topTrailing, "topTrailing"),
            (.bottom, "bottom"),
            (.bottomLeading, "bottomLeading"),
            (.bottomTrailing, "bottomTrailing"),
            (.trailing, "trailing"),
        ]
    }
}

extension Alignment {
    var unitPoint:UnitPoint {
        switch self {
        case .center:
            return .center
        case .leading:
            return .leading
        case .top:
            return .top
        case .topLeading:
            return .topLeading
        case .topTrailing:
            return .topTrailing
        case .bottom:
            return .bottom
        case .bottomLeading:
            return .bottomLeading
        case .bottomTrailing:
            return .bottomTrailing
        case .trailing:
            return .trailing
        default:
            return .center
        }
    }
}


extension Alignment {
    init(_ unitPoint:UnitPoint) {
        switch unitPoint {
        case .center:
            self = Self.center
        case .zero:
            self = Self.topLeading
        case .leading:
            self = Self.leading
        case .top:
            self = Self.top
        case .topLeading:
            self = Self.topLeading
        case .topTrailing:
            self = Self.topTrailing
        case .bottom:
            self = Self.bottom
        case .bottomLeading:
            self = Self.bottomLeading
        case .bottomTrailing:
            self = Self.bottomTrailing
        case .trailing:
            self = Self.trailing
        default:
            self = Self.center
            
        }
    }
}
