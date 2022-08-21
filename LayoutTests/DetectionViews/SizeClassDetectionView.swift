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
            Text("horizontalSizeClass: \(whatsTheHSize)")
        Divider()
            Text("verticalSizeClass:  \(whatsTheVSize)")
        Divider()
            Text("dynamicTypeSize: \(whatsTheTypeSize)")
        .transformEnvironment(\.horizontalSizeClass) { dump($0) }
            .transformEnvironment(\.verticalSizeClass) { dump($0) }
            .transformEnvironment(\.dynamicTypeSize) { dump($0) }
    }
    
    var whatsTheHSize:String {
        switch hSizeClass {
        case .compact:
            return "compact"
        case .none:
            return "none"
        case .some(.regular):
            return "regular"
        case .some(_):
            return "somebody new"
        }
    }
    
    var whatsTheVSize:String {
        switch vSizeClass {
        case .compact:
            return "compact"
        case .none:
            return "none"
        case .some(.regular):
            return "regular"
        case .some(_):
            return "somebody new"
        }
    }
    
    var whatsTheTypeSize:String {
        switch typeSize {
        case .xSmall:
            return "xSmall"
        case .small:
            return "small"
        case .medium:
            return "medium"
        case .large:
            return "large"
        case .xLarge:
            return "xLarge"
        case .xxLarge:
            return "xxLarge"
        case .xxxLarge:
            return "xxxLarge"
        case .accessibility1:
            return "accessibility1"
        case .accessibility2:
            return "accessibility2"
        case .accessibility3:
            return "accessibility3"
        case .accessibility4:
            return "accessibility4"
        case .accessibility5:
            return "accessibility5"
        @unknown default:
            return "somebody new"
        }
    }
}
    
    struct SizeClassDetectionView_Previews: PreviewProvider {
        static var previews: some View {
            SizeClassDetectionView()
        }
    }
