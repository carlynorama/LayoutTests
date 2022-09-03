//
//  FormView.swift
//  LayoutTests
//
//  Created by Labtanza on 8/28/22.
//

import SwiftUI

struct FormView: View {
    @State var value:Double = 57
    
    @State var now:Date = Date()
    
    var body: some View {
        Form {
            PickerView(value: $value)
            PickerPopoverView(value: $value, isEmbeded: true)
            DatePicker("Date", selection: $now)
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
