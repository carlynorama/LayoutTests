//
//  ChooserView.swift
//  LayoutTests
//
//  Created by Labtanza on 8/28/22.
//

import SwiftUI




struct PickerPopoverView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dynamicTypeSize) var typeSize
    
    @Binding var value:Double
    @State var buffer:Double = 0
    @State var previousValues:[Result] = []
    
    @State var showingResults = false
    var isEmbeded = false
    
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 10.0) {
            //The "Toolbar"
            if !isEmbeded {
                HStack {
                    //Button("Update") { updateLocation() }
                    Spacer()
                    Button("Close") { close() }
                }
                Spacer()
            }
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
        PickerPopoverView(value:Binding.mock(34.5))
    }
}
