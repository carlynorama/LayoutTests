//
//  ContentView.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        EStackTests()
        //       HPreferingStack {
//            SizeClassDetectionView()
//            Divider()
//            DeviceDetection()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
          ContentView()
              .environment(\.sizeCategory, .extraSmall)
          ContentView()
          ContentView()
              .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      }
}
