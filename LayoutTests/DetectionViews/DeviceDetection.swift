//
//  DeviceDetection.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
// https://stackoverflow.com/questions/24065017/how-to-determine-device-type-from-swift-os-x-or-ios

import SwiftUI

struct DeviceDetection: View {
    let currentDevice = UIDevice.current
    var body: some View {
        VStack {
            Text(currentDevice.description)
            Text(currentDevice.localizedModel)
            Text(currentDevice.systemName)
            Text(currentDevice.systemVersion)
            Text("\(idiom)")
            Text(isChangingOrientation)
        }
    }
    
    var isChangingOrientation:String {
        if currentDevice.isGeneratingDeviceOrientationNotifications {
            return "Rotation enabled"
        } else {
            return "Rotation locked"
        }
    }
    

    var idiom:String {
        //MacCatalyst apps default to iPad idiom unless specified
        //https://developer.apple.com/documentation/uikit/mac_catalyst/choosing_a_user_interface_idiom_for_your_mac_app/
        #if targetEnvironment(macCatalyst)
        return "macCatalyst - decide whether to do and idiom override"
        #endif
        
        switch currentDevice.userInterfaceIdiom {
            
        case .unspecified:
            return ".unspecified"
        case .phone:
            return ".phone"
        case .pad:
            return ".pad"
        case .tv:
            return ".tv"
        case .carPlay:
            return ".carPlay"
        case .mac:
            return ".mac"
        @unknown default:
            return "something new"
        }
    }
//    var currentDevice:String {
//
//        #if targetEnvironment(macCatalyst)
//        return "nativeMac"
//        #elseif os(watchOS)
//        return "watchOS"
//        #endif
//
//        let currentDevice = UIDevice.current//.description
//        return currentDevice.description
//        switch currentDevice {
//        case let str where str.contains("iPad"):
//            return "iPad"
//        case let str where str.contains("iPhone"):
//            return "iPhone"
//        case let str where str.contains("watchOS"):
//            return "watchOS"
//        case let str where str.contains("watchOS"):
//            return "watchOS"
//        default:
//            return "Something I don't recognize."
//        }
//
//    }
}

struct DeviceDetection_Previews: PreviewProvider {
    static var previews: some View {
        DeviceDetection()
    }
}
