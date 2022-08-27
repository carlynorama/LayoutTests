//
//  LayoutThatKnows.swift
//  LayoutTests
//
//  Created by Labtanza on 8/27/22.
//

import SwiftUI

extension View {
    
    func logSizes(_ label:String) -> some View {
        LogSizes(label:label) { self }
        
    }
}

struct LogSizes:Layout {
    var label:String
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        assert(subviews.count == 1)
        print("\(label) proposed: \(proposal.pretty)")
        let result = subviews[0].sizeThatFits(proposal)
        //print("\(label): \n\tproposed - \(proposal.pretty) \n\tresult - \(result)")
        print("\(label) result: \(result.pretty)")
        return result
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        subviews[0].place(at: bounds.origin, proposal: proposal)
    }
    
    
}
