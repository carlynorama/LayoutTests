//
//  WrappingWrappersTest.swift
//  LayoutTests
//
//  Created by Labtanza on 8/23/22.
//

import SwiftUI

struct WrappingWrappersTest: View {
    @State var proposedHeight:CGFloat = 100
    @State var proposedWidth:CGFloat = 100
    @State var anchor:UnitPoint = .topLeading
    @State var style:MyStyle = .compactVerticalBlock
    
    var body: some View {
        VStack {
            Picker("Style", selection: $style) {
                ForEach(MyStyle.allCases) { algo in
                    Text("\(algo.rawValue)")
                }
            }
            .pickerStyle(.segmented)
            WrappingLayout(anchor: anchor, manualSize:CGSize(width: proposedWidth, height:proposedHeight), style: style) {
                
                Rectangle().fill(.blue)
                    .frame(maxWidth: .infinity)
                    .frame(width: proposedWidth/2).opacity(0.5).border(.red)
                Rectangle().fill(.blue)
                    .frame(maxHeight: .infinity)
                    .frame(height: proposedHeight/2).opacity(0.5).border(.orange)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum feugiat nibh in consectetur cursus. Phasellus non tristique neque. Fusce sit amet vulputate tellus, quis ultrices magna. Sed ornare molestie cursus. Nulla vitae sem velit. Etiam tincidunt vel metus a euismod. Morbi tempus posuere erat a feugiat. Maecenas cursus ut massa eu pharetra. Quisque scelerisque erat et nisl porttitor commodo. Pellentesque erat erat, aliquam quis ex vitae, finibus bibendum tellus. ").border(.yellow)
                Text("Hello, World!").border(.green)
//                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fill).opacity(0.5)
                Image(systemName: "star").resizable().aspectRatio(contentMode: .fit).opacity(0.5).border(.blue)
                Image(systemName: "trash").resizable().frame(width: proposedWidth, height: proposedHeight).opacity(0.5).border(.cyan)
            }
            //        .logSizes("Wrapping Layout")
            .border(.pink)
            .padding(10)
            
            Slider(value: $proposedWidth, in: 25...300)
            Slider(value: $proposedHeight, in: 25...300)
//            ZStack(alignment: Alignment(anchor)) {
//                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fill).frame(width: proposedWidth, height: proposedHeight).opacity(0.5)
//                Image(systemName: "star").resizable().aspectRatio(contentMode: .fit).frame(width: proposedWidth, height: proposedHeight).opacity(0.5)
//                Image(systemName: "trash").resizable().frame(width: proposedWidth, height: proposedHeight).opacity(0.5)
//            }
        }
    }
}

struct WrappingWrappersTest_Previews: PreviewProvider {
    static var previews: some View {
        WrappingWrappersTest()
    }
}


