//
//  View+Extension.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 08/11/21.
//

import Foundation
import SwiftUI

internal struct VerticalHeightPreference: PreferenceKey {
    typealias Value = [Int: CGFloat]
    /// Provide a default value for custom dependency
    static let defaultValue: Value = [:]

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

internal extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func flipHorizontally() -> some View {
        return self
            .rotationEffect(.radians(.pi))
            .scaleEffect(x: 1, y: -1, anchor: .center)
    }
    
    /// Stores the height for each of column which will be passed as part of onPreferenceChange to parent view.
    func heightPreference(column: Int? = 0) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: VerticalHeightPreference.self, value: [column!: proxy.size.height])
        })
    }
    
    @available(iOS 14.0, *)
    func redactedIfApplicable(dataLoaded: Bool = false) -> some View {
        return AnyView(self.redacted(reason: dataLoaded ? [] : .placeholder))
    }
}
