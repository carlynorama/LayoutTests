//
//  CGExtentions.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
//

import Foundation
import SwiftUI

extension CGSize:Comparable {
    public static func < (lhs: CGSize, rhs: CGSize) -> Bool {
        lhs.sumOfSquares() < rhs.sumOfSquares()
    }
    
    var aspectRatio:CGFloat{
        self.width / self.height
    }
    
    static func sumOfSquares(_ a:CGFloat, _ b:CGFloat) -> CGFloat {
        return pow(a, 2) + pow(b, 2)
    }
    
    static func sumOfSquares(r:Self) -> CGFloat {
        return sumOfSquares(r.width, r.height)
    }
    
    func sumOfSquares() -> CGFloat {
        Self.sumOfSquares(self.width, self.height)
    }
    
    func diagonal() -> CGFloat {
        pow(Self.sumOfSquares(self.width, self.height), 0.5)
    }
}


extension CGSize {
    var minX:CGFloat { 0 }
    var minY:CGFloat { 0 }
    var midX:CGFloat { width/2 }
    var midY:CGFloat { height/2 }
    var maxX:CGFloat { width }
    var maxY:CGFloat { height }
}


extension CGSize {
    func anchorForAlignment(horizontal:HorizontalAlignment = .leading, vertical:VerticalAlignment = .top) -> CGPoint? {
        
        let fullAlignment = Alignment(horizontal: horizontal, vertical: vertical)
        return anchorForAlignment(fullAlignment)
    }
    
    func anchorForAlignment(_ alignment:Alignment) -> CGPoint? {
        alignment.unitPoint?.anchorPoint(for: self)
    }
}

extension CGRect {
    func anchorForAlignment(horizontal:HorizontalAlignment = .leading, vertical:VerticalAlignment = .top) -> CGPoint? {
        
        let fullAlignment = Alignment(horizontal: horizontal, vertical: vertical)
        return anchorForAlignment(alignment: fullAlignment)
    }
    
    func anchorForAlignment(alignment:Alignment) -> CGPoint? {
        alignment.unitPoint?.anchorPoint(for: self)
    }
}

extension CGPoint {
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
}


