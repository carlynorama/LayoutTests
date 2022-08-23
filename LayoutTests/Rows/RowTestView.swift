//
//  RowTestView.swift
//  LayoutTests
//
//  Created by Labtanza on 8/23/22.
//

import SwiftUI


struct DecoratedText:View {
    var text:String
    var body: some View {
        Text(text)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        
    }
}

struct SomeRowText:View {
    let title:String = "A Title Goes Here"
    let description:String = "A captions goes here."
    var body:some View {
        VStack(alignment: .leading) {
                Text("\(title)")
                .multilineTextAlignment(.leading)
                .allowsTightening(true)
                Text("\(description)")
                .font(.caption)
                .multilineTextAlignment(.leading)
                .allowsTightening(true)
            }
    }
}

struct TallRowText:View {
    let title:String = "A Title Goes Here. A Title Goes Here.A Title Goes Here A Title Goes HereA Title Goes HereA Title Goes HereA Title Goes Here"
    let description:String = "A captions goes here."
    var body:some View {
        VStack(alignment: .leading) {
                Text("\(title)")
                .multilineTextAlignment(.leading)
                .allowsTightening(true)
                Text("\(description)")
                .font(.caption)
                .multilineTextAlignment(.leading)
                .allowsTightening(true)
            Text("\(title)")
            .multilineTextAlignment(.leading)
            .allowsTightening(true)
            Text("\(description)")
            .font(.caption)
            .multilineTextAlignment(.leading)
            .allowsTightening(true)
            }
    }
}

struct ARow:View {
    var body: some View {
        EHHStack {
            Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit)
            Spacer()
            SomeRowText()
        }
    }
}

struct ABunchOfRows:View {
    var body: some View {
        ForEach(1..<2) { _ in
            ARow()
        }
    }
}

struct TheLoop:View {
    var strings:[String]
    var body: some View {
        ForEach(strings, id:\.self) { text in
            DecoratedText(text: text)
            Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit)
        }
    }
}

struct RowTestView: View {
//    var strings = "Lorem ipson dolor set ammet consectetur adipiscing elit".components(separatedBy: " ")
    var strings = "Lorem ipson dolor set".components(separatedBy: " ")
    
    var body: some View {
        VStack {
            TallRowText()
//            Text("Some short Text. Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.").logSizes("Text")
//            Label("Some short Text. Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.", systemImage: "globe").logSizes("Label").border(.pink)
//            Label(title: {SomeRowText()}, icon: {           Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit)
//
//            }).border(.pink)
//            Label(title: {SomeRowText()}, icon: {           Image(systemName: "globe")
//
//            }).border(.pink)
//            
//            EHLabel {
//                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit).border(.blue)
//                Spacer()
//                SomeRowText().border(.blue)
//            }.border(.pink)
            EHLabel {
                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit).border(.blue)
                Spacer().border(.green)
                //SomeRowText().border(.blue)
                TallRowText().border(.blue)
            }
//            HStack {
//                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit).border(.blue)
//                Spacer().border(.green)
//                Text("Some short Text. Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.").logSizes("Inside Text")
//            }
            
            EHLabel {
//                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit).border(.blue)
//                Spacer()
                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit)                    .layoutPriority(11).border(.blue)
                Spacer().border(.green)//.layoutPriority(11)
                //SomeRowText().border(.blue)
                //TallRowText().border(.blue)
                //Text("Some short Text.")
                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit)                    .layoutPriority(11).border(.blue)
                Text("Some short Text. Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.").logSizes("Inside Text")
                    .layoutPriority(11)
                //.layoutPriority(6)
//                VStack{
//                    Text("Some short Text. Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.")
//                }
//                    //.fixedSize(horizontal: false, vertical: false)
                    //.layoutPriority(5)
                    //.fixedSize(horizontal: false, vertical: true)
            }.border(.pink)
                .padding()
            
            //ARow().border(.pink)
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
}


struct RowTestView_Previews: PreviewProvider {
    static var previews: some View {
        RowTestView()
    }
}
