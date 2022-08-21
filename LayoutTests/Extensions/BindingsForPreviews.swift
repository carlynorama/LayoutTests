//
//  BindingsForPreviews.swift
//  LayoutTests
//
//  Created by Labtanza on 8/21/22.
//

import Foundation
import SwiftUI

extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
}
