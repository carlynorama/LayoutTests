//
//  SizeClassDetectionView.swift
//  AnimationTests
//
//  Created by Labtanza on 8/21/22.
//

import SwiftUI




struct SizeClassDetectionView: View {
    @Environment(\.horizontalSizeClass) var hSizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    var body: some View {
        Text("Nothing yet")
//        Text("hSizeClass: \(hSizeClass)")
//        Text("SizeClass: \(vSizeClass)")
//        Text("SizeClass: \(typeSize)")
    }
}

struct SizeClassDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        SizeClassDetectionView()
    }
}
