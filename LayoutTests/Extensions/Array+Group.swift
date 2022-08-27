//
//  Array+Group.swift
//  objc_ViewSystem
//
//  Created by Labtanza on 8/26/22.
//

import Foundation

//https://www.swiftbysundell.com/articles/sorting-swift-collections/
//let sortedTags = tags.sorted(by: \.rawValue)
//let sortedTodoItems = todoItems.sorted(by: \.date)
//let mostRecentTodoItems = todoItems.sorted(by: \.date, using: >)
extension Sequence {
    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        using comparator: (T, T) -> Bool = (<)
    ) -> [Element] {
        sorted { a, b in
            comparator(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }
}

//func sortArticlesByCategory(_ articles: [Article]) -> [Article] {
//    articles.sorted { articleA, articleB in
//        guard articleA.category == articleB.category else {
//            return articleA.category < articleB.category
//        }
//
//        return articleA.title < articleB.title
//    }
//}


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
