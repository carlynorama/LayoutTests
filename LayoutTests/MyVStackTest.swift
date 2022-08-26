//
//  MyVStackTest.swift
//  LayoutTests
//
//  Created by Labtanza on 8/26/22.
//

import SwiftUI

struct MyVStackTest: View {
    @State var proposedHeight:CGFloat = 100
    @State var proposedWidth:CGFloat = 100
    @State var opacity: Double = 0.5
    
    @ViewBuilder var sampleView: some View {
        Rectangle().fill(.blue)
            .frame(maxWidth: .infinity)
            .frame(width: proposedWidth/2).opacity(0.5).border(.red)
        Rectangle().fill(.blue)
            .frame(maxHeight: .infinity)
            .frame(height: proposedHeight/2)
            .opacity(0.5).border(.orange)
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum feugiat nibh in consectetur cursus. Phasellus non tristique neque. Fusce sit amet vulputate tellus, quis ultrices magna. Sed ornare molestie cursus. Nulla vitae sem velit. Etiam tincidunt vel metus a euismod. Morbi tempus posuere erat a feugiat. Maecenas cursus ut massa eu pharetra. Quisque scelerisque erat et nisl porttitor commodo. Pellentesque erat erat, aliquam quis ex vitae, finibus bibendum tellus. ").border(.yellow)
        Text("Hello, World!").border(.green)
        //                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fill).opacity(0.5)
        Image(systemName: "star").resizable().aspectRatio(contentMode: .fit).opacity(0.5).border(.blue)
        Image(systemName: "trash").resizable().opacity(0.5).border(.cyan)
        
    }
    
    
    @State var alignment:Alignment = .center
    var body: some View {
        VStack {
            ZStack {
                MyVStackLayout() {
                    sampleView
                    
                }
                .logSizes("MyVStack")
                .opacity(1-opacity)
                .border(.pink, width: 3)
                VStack {
                    sampleView
                }
                .logSizes("VStack")
                .opacity(opacity)
                .border(.pink, width: 3)
            }
            //.frame(width: proposedWidth, height: proposedHeight)
            .border(.blue, width: 3)
            .padding(10)
            VStack {
                HStack {Text("NotSwiftUI");Spacer();Text("SwiftUI")}
                Slider(value: $opacity, in: 0...1)
            }
            
            HStack {
                Text("Width - \(proposedWidth.rounded())")
                Slider(value: $proposedWidth, in: 25...300)
            }
            HStack {
                Text("Height - \(proposedHeight.rounded())")
                Slider(value: $proposedHeight, in: 25...300)
            }
            
        }
    }
}

struct MyVStackTest_Previews: PreviewProvider {
    static var previews: some View {
        MyVStackTest()
    }
}
