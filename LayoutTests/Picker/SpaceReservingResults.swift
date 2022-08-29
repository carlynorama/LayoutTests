//
//  ReservingSpaceLayout.swift
//  LayoutTests
//
//  Created by Labtanza on 8/28/22.
//

import SwiftUI

struct SpaceReservingResults: View {
    var items:[Result]
    var body: some View {
        ReservingSpaceLayout() {
            ResultRow(result: Result.example).opacity(0)
            ScrollView() {
                VStack(alignment: .trailing) {
                    ForEach(items) { item in
                        ResultRow(result: item).border(.green)
                    }
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}


struct ResultRow:View {
    let result:Result
    

    
    var body: some View {
        HStack {
            //Image(systemName: "globe")
            VStack() {
                //Text("Value:\(result.value.pretty)").font(.title)
                //Text("\(result.id)").font(.caption)
                
                Text("Value:\(result.value.pretty)")
                    .multilineTextAlignment(.leading)
                    //.allowsTightening(true)
                Text("\(result.id)")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    //.allowsTightening(true)
            }
            
        }
    }
    
    //    func sizeThatFits(_ proposal:ProposedViewSize) -> CGSize {
    //        proposal.replacingUnspecifiedDimensions()
    //    }
}



//struct ReservingSpaceLayout:Layout {
//
//    //needs a sizeThatFits
//    let limitingView:ResultRow = ResultRow(result: Result.example)
//    let count = 6.0
//
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        let sizeLimiter = limitingView.sizeThatFits(proposal)
//        let suggestedSize = proposal.replacingUnspecifiedDimensions()
//        var size = CGSize(width: max(sizeLimiter.width, suggestedSize.width), height: max(sizeLimiter.height * count, suggestedSize.height))
//        return size
//    }
//
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        guard subviews.count == 1 else {
//            print("This a container for 1 right now.")
//            fatalError("This a container for 1 right now.")
//        }
//
//
//        subviews[0].place(
//                at: bounds.origin,
//                proposal: proposal
//        )
//
//
//    }
//
//
//}


fileprivate struct ReservingSpaceLayout:Layout {
    
    //needs a sizeThatFits
    let limitingView:ResultRow = ResultRow(result: Result.example)
    let count = 6.0
    let widthComfort = 1.3
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizeLimiter = subviews[0].sizeThatFits(.unspecified)
        let suggestedSize = proposal.replacingUnspecifiedDimensions()
        let size = CGSize(width: max(sizeLimiter.width * widthComfort, suggestedSize.width).rounded(), height: max(sizeLimiter.height * count, suggestedSize.height))
        return size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard subviews.count == 2 else {
            print("This a container for 1 right now.")
            fatalError("This a container for 1 right now.")
        }
        
        
//        subviews[0].place(
//            at: CGPoint(x: -1000, y: -1000),
//            proposal: proposal
//        )
        
        subviews[1].place(
            at: bounds.origin,
            proposal: proposal
        )
        
        
    }
    
    
}
