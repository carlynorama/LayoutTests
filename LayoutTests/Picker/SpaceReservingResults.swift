//
//  ReservingSpaceLayout.swift
//  LayoutTests
//
//  Created by Labtanza on 8/28/22.
//

import SwiftUI

struct SpaceReservingViewResults: View {
    var items:[Result]
    
    @Binding var showingResults:Bool
    
    var body: some View {
        ReservingSpaceWithView() {
            ResultRow(result: Result.example).opacity(0)
            ZStack {
                PlacehoderView().opacity(showingResults ? 0:1)
                if showingResults {
                    ScrollView() {
                        VStack(alignment: .trailing) {
                            ForEach(items) { item in
                                ResultRow(result: item)
                            }
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                            .opacity(showingResults ? 1:0)
                            .transition(resultReveal)
                    }
                }
            }
        }
    }
    
    struct PlacehoderView:View {
        var body: some View {
            Rectangle().foregroundColor(Color(uiColor: .tertiarySystemFill))
                .border(.secondary)
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


//
//struct ReservingSpaceWithLayout:Layout {
//
//    //needs a sizeThatFits
//    let limitingLayout:some Shape = Rectangle()
//    let count = 6.0
//
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        let sizeLimiter = limitingLayout.sizeThatFits(proposal)
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

var resultReveal:AnyTransition {
    //AnyTransition.scale(scale: 2, anchor: UnitPoint(x: 1, y: 0))
    AnyTransition.opacity.combined(with: .move(edge: .top)).combined(with: verticalClipTransition)
}

struct VerticalClipEffect:ViewModifier {
    var value: CGFloat
    
    func body(content: Content) -> some View {
        content
            .clipShape(Rectangle().scale(x: 1, y: value, anchor: .top))
    }
}

var verticalClipTransition:AnyTransition {
    .modifier(
        active: VerticalClipEffect(value: 0),
        identity: VerticalClipEffect(value: 1)
    )
}


fileprivate struct ReservingSpaceWithView:Layout {
    
    //needs a sizeThatFits
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
