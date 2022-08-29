//
//  PickerView.swift
//  LayoutTests
//
//  Created by Labtanza on 8/28/22.
//

import SwiftUI

struct PickerView: View {
    
    
    @State private var showingPopover = false
    
    @Binding var value:Double
    
    var body: some View {
        HStack {
            Text("Hello, World! I am the value: ")
            LaunchPickerButton
        }.popover(isPresented: $showingPopover) {
            ChooserView(value: $value)
        }
    }
    
    @ViewBuilder var LaunchPickerButton:some View {
        Button(
            action: { showingPopover.toggle() },
            label: {
                Text("\(value.pretty)")
            }).buttonStyle(.borderedProminent).frame(width: 100)
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(value: Binding.mock(34.5))
    }
}
