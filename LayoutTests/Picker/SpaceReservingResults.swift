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
            //Will be used only as place holder.
            //If not opaque will be smack dab in the middle of the view.
            ResultRow(result: Result.example).opacity(0)
            //Could be written inline as long as all in one container.
            whatToActuallyDisplay()
        }
    }
    
    @ViewBuilder func whatToActuallyDisplay() -> some View {
        ZStack {
            PlacehoderView().opacity(showingResults ? 0:1)
            if showingResults {
                ScrollView() {
                    VStack(alignment: .trailing) {
                        ForEach(items) { item in
                            ResultRow(result: item)
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing)
                        .opacity(showingResults ? 1:0)
                        .transition(resultReveal)
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

//MARK: - Space Reserving View

fileprivate struct ReservingSpaceWithView:Layout {
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
            print("This a container for 2 right now.")
            fatalError("This a container for 2 right now.")
        }
        
         //Putting the resrving view out side of bounds messes up surrounding layout in some cases.
        //Not placing it at all, like this does, means it gets placed in the center of the view.
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

//MARK: - Result Data Structure and Row

struct Result:Identifiable, Hashable {
    let value:Double
    let id:UUID
    
    static var example:Result {
        Result(value: 43, id: UUID(uuidString:"F1A85EA3-E12F-46D7-9336-AA26A4E007C5")!)
    }
}

extension Result {
    init(value:Double) {
        self.value = value
        self.id = UUID()
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
    
}






//MARK: - Optional Modifiers
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
