//
//  VerticalBarChartView+Input.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 08/11/21.
//

import Foundation
import SwiftUI

public extension VerticalBarChartView {
    struct AttributedString: Hashable {
        let text: String
        let color: Color
        let uiFont: UIFont
        let alignment: Alignment
        let accessibilityLabel: String // accessibility label helps in the case of strings with formatted currency like "$6.1k" which VoiceOver reads as "6 dollars 10 cents k"
        
        public init(text: String, color: Color, uiFont: UIFont, alignment: Alignment = .center, accessibilityLabel: String? = nil) {
            self.text = text
            self.color = color
            self.uiFont = uiFont
            self.alignment = alignment
            self.accessibilityLabel = accessibilityLabel ?? text
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(text)
        }
    }
    
    struct SeperatorData {
        let title: AttributedString
        let subtitle: AttributedString
        public internal(set) var value: CGFloat
        let separatorColor: Color
        
        public init(title: AttributedString, subtitle: AttributedString, value: CGFloat, separatorColor: Color = .gray) {
            self.title = title
            self.subtitle = subtitle
            self.value = value
            self.separatorColor = separatorColor
        }
    }

    struct BarEntry: Hashable {
        let id: Int
        let xTopLabel: AttributedString?
        let xBottomLabel: AttributedString?
        let yTopLabel: AttributedString?
        let yBottomLabel: AttributedString?
        let backgroundValue: CGFloat
        let foregroundValue: CGFloat
        let backgroundColor: Color
        let foregroundColor: Color
        let dashedBackgroundColor: Color
        let dashedForegroundColor: Color
        let border: BarBorder
        
        public init(id: Int, xTopLabel: VerticalBarChartView.AttributedString? = nil, xBottomLabel: VerticalBarChartView.AttributedString? = nil, yTopLabel: VerticalBarChartView.AttributedString? = nil, yBottomLabel: VerticalBarChartView.AttributedString? = nil, backgroundValue: CGFloat, foregroundValue: CGFloat, backgroundColor: Color, foregroundColor: Color, dashedBackgroundColor: Color, dashedForegroundColor: Color, border: BarBorder = .none) {
            self.id = id
            self.xTopLabel = xTopLabel
            self.xBottomLabel = xBottomLabel
            self.yTopLabel = yTopLabel
            self.yBottomLabel = yBottomLabel
            self.backgroundValue = backgroundValue
            self.foregroundValue = foregroundValue
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.dashedBackgroundColor = dashedBackgroundColor
            self.dashedForegroundColor = dashedForegroundColor
            self.border = border
        }
    }
}
