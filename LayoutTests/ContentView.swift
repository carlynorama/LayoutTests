//
//  ContentView.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
//

import SwiftUI

struct ContentView: View {
    @State var selected:Int = 1
    var body: some View {
        
        TabView(selection: $selected) {
            MyVStackTest().tabItem { Text("VStack Replica") }.tag(1)
            RowTestView().tabItem { Text("RowView") }.tag(2)
            VStackExperimentsTest().tabItem { Text("VStack Experiments") }.tag(4)
            //EStackTests().tabItem { Text("EStack") }.tag(5)
            HPreferingStack{
                SizeClassDetectionView()
                Divider()
                DeviceDetection()
            }.tabItem { Text("E & D") }.tag(6)
            AStack() {
                    Text("Horizontal when its wide")
                    Text("but")
                    Text("Vertical when its narrow")
                    Text("Uses ViewThatKnows")
                }.tabItem { Text("ViewThatKnows") }.tag(7)
            }
            LayoutThatKnowsTestView().tabItem { Text("Layout That Knows") }.tag(3)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//          ContentView()
//              .environment(\.sizeCategory, .extraSmall)
          ContentView()
//          ContentView()
//              .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      }
}
