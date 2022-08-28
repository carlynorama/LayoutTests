//
//  Alignement.swift
//  LayoutTests
//
//  Created by Labtanza on 8/27/22.
//

import SwiftUI


extension Alignment {
    var unitPoint:UnitPoint? {
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
            return nil
        }
    }
    

}


extension Alignment {
    init?(_ unitPoint:UnitPoint) {
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
            return nil
        }
    }
}
