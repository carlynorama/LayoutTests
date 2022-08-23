//
//  CGExtentions.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
//

import Foundation


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
