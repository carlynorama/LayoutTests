//
//  Pretty.swift
//  LayoutTests
//
//  Created by Labtanza on 8/28/22.
//

import Foundation
import SwiftUI

extension Double {
    var pretty: String {
        String(format: "%.2f", self)
    }
}

extension CGFloat {
    var pretty: String {
        String(format: "%.2f", self)
    }
}

extension CGSize {
    var pretty: String {
        "\(width.pretty)⨉\(height.pretty)"
    }
}

//wrapped conforms to pretty?
extension Optional where Wrapped == CGFloat {
    var pretty: String {
        self?.pretty ?? "nil"
    }
}

extension ProposedViewSize {
    var pretty: String {
        "\(width.pretty)⨉\(height.pretty)"
    }
}
