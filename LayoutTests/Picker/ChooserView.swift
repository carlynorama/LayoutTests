//
//  ChooserView.swift
//  LayoutTests
//
//  Created by Labtanza on 8/28/22.
//

import SwiftUI

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


struct ChooserView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dynamicTypeSize) var typeSize
    
    @Binding var value:Double
    @State var buffer:Double = 0
    @State var previousValues:[Result] = []
    
    @State var showingResults = false
    
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 10.0) {
            //The "Toolbar"
            HStack {
                //Button("Update") { updateLocation() }
                Spacer()
                Button("Close") { close() }
            }
            Spacer()
            Stepper("\(value.pretty)", value: $value).onChange(of: value) { newValue in
                previousValues.append(Result(value: buffer))
                buffer = newValue
                withAnimation {
                    showingResults = true
                }
            }
            Spacer()
            SpaceReservingViewResults(items: previousValues, showingResults: $showingResults)
        }.padding()
            .onAppear() {
                buffer = value
            }
    }
    
    func close() {
        presentationMode.wrappedValue.dismiss()
        print(UUID())
    }
}






struct ChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ChooserView(value:Binding.mock(34.5))
    }
}
