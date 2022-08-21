//
//  ContentView.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AStack {
            SizeClassDetectionView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
