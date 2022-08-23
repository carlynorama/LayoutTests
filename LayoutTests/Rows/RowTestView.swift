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
            Label("Some short Text. Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.", systemImage: "globe").border(.pink)
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
                Spacer()
                Image(systemName: "globe").resizable().aspectRatio(contentMode: .fit).border(.blue)
                Spacer()
                //SomeRowText().border(.blue)
                //TallRowText().border(.blue)
                //Text("Some short Text.")
                Text("Some short Text. Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.")
                    .layoutPriority(6)
                //.layoutPriority(6)
//                VStack{
//                    Text("Some short Text. Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.Some short Text.")
//                }
//                    //.fixedSize(horizontal: false, vertical: false)
                    //.layoutPriority(5)
                    //.fixedSize(horizontal: false, vertical: true)
            }.border(.pink)
            
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