//
//  WrappingWrappersTest.swift
//  LayoutTests
//
//  Created by Labtanza on 8/23/22.
//

import SwiftUI

struct VStackExperimentsTest: View {
    @State var proposedHeight:CGFloat = 400
    @State var proposedCellHeight:CGFloat = 20
    @State var useCellHeight = false
    @State var proposedWidth:CGFloat = 100
    
    var alignements:[UnitPoint] = [.center, .bottomTrailing, .topLeading]

    @State var anchor:UnitPoint = .bottomTrailing
    @State var style:MyStyle = .manualBlock//.boundingHeight
    
    var body: some View {
        VStack {
            VStack {
                Picker("Alignment", selection: $anchor) {
                    ForEach(alignements, id:\.self) { alignment in
                        Text(alignment.menuText)
                    }
                }
                Picker("Style", selection: $style) {
                    ForEach(MyStyle.allCases) { style in
                        Text("\(style.rawValue)")
                    }
                }.task(id: style) {
                    useCellHeight = style.usesCellHeight
                }
                Spacer()
                Toggle(isOn: $useCellHeight, label: {Text("Uses Cell Height")})
            }
           
            VStackExperiments(anchor: anchor, manualSize:CGSize(width: proposedWidth, height: useCellHeight ? proposedCellHeight : proposedHeight), style: style) {
                
                Rectangle().fill(.blue)
                    .frame(maxWidth: .infinity)
                    .frame(width: proposedWidth/2).opacity(0.5).border(.red)
                Rectangle().fill(.blue)
                    .frame(maxHeight: .infinity)
                    //.frame(height: proposedHeight/2)
                    .opacity(0.5).border(.orange)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum feugiat nibh in consectetur cursus. Phasellus non tristique neque. Fusce sit amet vulputate tellus, quis ultrices magna. Sed ornare molestie cursus. Nulla vitae sem velit. Etiam tincidunt vel metus a euismod. Morbi tempus posuere erat a feugiat. Maecenas cursus ut massa eu pharetra. Quisque scelerisque erat et nisl porttitor commodo. Pellentesque erat erat, aliquam quis ex vitae, finibus bibendum tellus. ").border(.yellow)
                Text("Hello, World!").border(.green)
//                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fill).opacity(0.5)
                Image(systemName: "star").resizable().aspectRatio(contentMode: .fit).opacity(0.5).border(.blue)
                Image(systemName: "trash").resizable().opacity(0.5).border(.cyan)
            }
            //        .logSizes("Wrapping Layout")
            .border(.pink)
            .padding(10)
            
            HStack {
                Text("Width:")
                Slider(value: $proposedWidth, in: 25...300)
            }
            HStack {
                Text("Cell Hight:")
                Slider(value: $proposedCellHeight, in: 10...100)
            }
            HStack { Text("Height:")
                Slider(value: $proposedHeight, in: 100...500)
            }
            
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
        VStackExperimentsTest()
    }
}


