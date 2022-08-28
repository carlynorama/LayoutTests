//
//  AnchorsUnitPoints.swift
//  LayoutTests
//
//  Created by Labtanza on 8/23/22.
//

import Foundation
import SwiftUI


extension UnitPoint {
    func translated(_ point:CGPoint) -> UnitPoint{
        UnitPoint(x: self.x + point.x, y: self.y + point.y)
    }
    
    func translated(x:CGFloat) -> UnitPoint{
        UnitPoint(x: self.x + x, y: self.y)
    }
    
    func translated(y:CGFloat) -> UnitPoint{
        UnitPoint(x: self.x, y: self.y + y)
    }
    
    func translated(x:CGFloat, y:CGFloat) -> UnitPoint{
        UnitPoint(x: self.x + x, y: self.y + y)
    }
}


extension UnitPoint {
    func anchorPoint(for bounds: CGRect) -> CGPoint {
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
    
    func anchorPoint(for size: CGSize) -> CGPoint {
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
    
    var menuText:String {
        switch self {
        case .center: return "center"
        case .leading: return "leading"
        case .top: return "top"
        case .topLeading: return "topLeading"
        case .topTrailing: return "topTrailing"
        case .bottom: return "bottom"
        case .bottomLeading: return "bottomLeading"
        case .bottomTrailing: return "bottomTrailing"
        case .trailing: return "trailing"
        //case .zero: return "zero"
        default:
            return "Undefined:(\(self.x), \(self.y))"
        }
    }
}

extension UnitPoint {
    public enum Axis {
        case vertical, horizontal
    }
    
    init?(_ alignment:Alignment) {
        guard let u = alignment.unitPoint else {
            return nil
        }
        self = u
    }
    
    init?(horizontal:HorizontalAlignment) {
        guard let u = Alignment(horizontal: horizontal, vertical: .top).unitPoint else {
            return nil
        }
        self = u
    }
    
    init?(vertical:VerticalAlignment) {
        guard let u = Alignment(horizontal: .leading, vertical: vertical).unitPoint else {
            return nil
        }
        self = u
    }
    
    init?(horizontal:HorizontalAlignment, vertical:VerticalAlignment) {
        guard let u = Alignment(horizontal: horizontal, vertical: vertical).unitPoint  else {
            return nil
        }
        self = u
    }
    
    init?(dimension:CGSize, base:UnitPoint? = nil, computeValue:@escaping (CGSize) -> CGPoint) {
        var newUnitPoint = base ?? .zero
        let translation = computeValue(dimension)
        self = newUnitPoint.translated(translation)
    }
    
    init?(axis: Axis, dimension:CGSize, base:UnitPoint? = nil, computeValue:@escaping (CGSize) -> CGFloat) {
        var newUnitPoint = base ?? .zero
        let translation = computeValue(dimension)
        if axis == .horizontal {
            self = newUnitPoint.translated(x: translation)
        } else {
            self = newUnitPoint.translated(y: translation)
        }
    }
}
