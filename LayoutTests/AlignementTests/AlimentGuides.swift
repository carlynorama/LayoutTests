//
//  AlimentGuides.swift
//  LayoutTests
//
//  Created by Labtanza on 8/27/22.
/*
 https://developer.apple.com/documentation/swiftui/horizontalalignment
 https://developer.apple.com/documentation/swiftui/alignmentid
 */

import SwiftUI

struct AlimentGuides: View {
    var body: some View {
        VStack {
            LayeredVerticalStripes()
            StripesGroup()
        }
    }
}

private struct FirstThirdAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context.height / 3
    }
}

extension VerticalAlignment {
    static let firstThird = VerticalAlignment(FirstThirdAlignment.self)
}


extension HorizontalAlignment {
    static let oneQuarter = HorizontalAlignment(OneQuarterAlignment.self)
}

private struct OneQuarterAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context.width / 4
    }
}

struct HorizontalStripes: View {
    var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<3) { _ in Color.blue }
        }
    }
}


struct StripesGroup: View {
    var body: some View {
        VStack{
            HStack(alignment: .firstThird, spacing: 1) {
                HorizontalStripes().frame(height: 60)
                HorizontalStripes().frame(height: 120)
                HorizontalStripes().frame(height: 90)
            }
            HStack(alignment: .firstThird, spacing: 1) {
                HorizontalStripes().frame(height: 60)
                HorizontalStripes().frame(height: 120)
                HorizontalStripes().frame(height: 90)
                    .alignmentGuide(.firstThird) { context in
                        2 * context.height / 3
                    }
            }
            HStack(alignment: .firstThird, spacing: 1) {
                HorizontalStripes().frame(height: 60)
                HorizontalStripes().frame(height: 120)
                HorizontalStripes().frame(height: 90)
            }
        }
    }
}





struct LayeredVerticalStripes: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .oneQuarter, vertical: .center)) {
            verticalStripes(color: .blue)
                .frame(width: 300, height: 150)
            verticalStripes(color: .green)
                .frame(width: 180, height: 80)
        }
    }


    private func verticalStripes(color: Color) -> some View {
        HStack(spacing: 1) {
            ForEach(0..<4) { _ in color }
        }
    }
}

struct AlimentGuides_Previews: PreviewProvider {
    static var previews: some View {
        AlimentGuides()
    }
}
