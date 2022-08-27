//
//  Array+Group.swift
//  objc_ViewSystem
//
//  Created by Labtanza on 8/26/22.
//

import Foundation

//https://github.com/objcio/S01E235-swiftui-layout-explained-layout-priorities/blob/master/SwiftUILayout/Helpers.swift


extension Array {
    // var groups = flexibility.group(by: \.priority)
    // expectes the array to be sorted by groupId
    // returns an arry of arrays
    func group<A: Equatable>(by groupId: (Element) -> A) -> [[Element]] {
        guard !isEmpty else { return [] }
        var groups: [[Element]] = []
        var currentGroup: [Element] = [self[0]]
        for element in dropFirst() {
            if groupId(currentGroup[0]) == groupId(element) {
                currentGroup.append(element)
            } else {
                groups.append(currentGroup)
                currentGroup = [element]
            }
        }
        groups.append(currentGroup)
        return groups
    }
}

import SwiftUI

extension Array where Element: BinaryFloatingPoint {
    func average() -> Element? {
        guard !isEmpty else { return nil }
        let factor = 1/Element(count)
        return map { $0 * factor }.reduce(0,+)
    }
}
