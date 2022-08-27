//
//  EStackTests.swift
//  LayoutTests
//
//  Created by Labtanza on 8/22/22.
//

import SwiftUI
//
//struct DecoratedText:View {
//    var text:String
//    var body: some View {
//        Text(text)
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(.yellow)
//            .clipShape(RoundedRectangle(cornerRadius: 5))
//
//    }
//}
//
//struct SomeRowText:View {
//    let title:String = "A Title Goes Here"
//    let description:String = "A captions goes here."
//    var body:some View {
//        VStack(alignment: .leading) {
//                Text("\(title)")
//                .multilineTextAlignment(.leading)
//                .allowsTightening(true)
//                Text("\(description)")
//                .font(.caption)
//                .multilineTextAlignment(.leading)
//                .allowsTightening(true)
//            }
//    }
//}
//
//struct ARow:View {
//    var body: some View {
//        EHHStack {
//            Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit)
//            Spacer()
//            SomeRowText()
//        }
//    }
//}
//
//struct ABunchOfRows:View {
//    var body: some View {
//        ForEach(1..<2) { _ in
//            ARow()
//        }
//    }
//}
//
//struct TheLoop:View {
//    var strings:[String]
//    var body: some View {
//        ForEach(strings, id:\.self) { text in
//            DecoratedText(text: text)
//            Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit)
//        }
//    }
//}

struct EStackTests: View {
//    var strings = "Lorem ipson dolor set ammet consectetur adipiscing elit".components(separatedBy: " ")
    var strings = "Lorem ipson dolor set".components(separatedBy: " ")

    var body: some View {

        ARow().border(.pink)
//        ViewThatFits {
//            EHHStack {
//                TheLoop(strings: strings)
//            }
//            EWVStack {
//                TheLoop(strings: strings)
//            }
//        }
    }
}

struct EStackTests_Previews: PreviewProvider {
    static var previews: some View {
        EStackTests()
    }
}
