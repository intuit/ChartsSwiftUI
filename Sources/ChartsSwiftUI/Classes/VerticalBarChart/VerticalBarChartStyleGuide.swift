//
//  VerticalBarChartStyleGuide.swift
//  ChartsSwiftUI
//
//  Created by rsingh26 on 08/11/21.
//

import Foundation
import SwiftUI

public protocol VerticalBarChartStyleGuide {
    var barWidth: CGFloat { get }
    var barSpacing: CGFloat { get }
    var barChartHeight: CGFloat? { get }
    var xTopLabelSpacing: CGFloat { get }
    var xBottomLabelSpacing: CGFloat { get }
    var yTopLabelSpacing: CGFloat { get }
    var yBottomLabelSpacing: CGFloat { get }
    var barCornerRadius: CGFloat { get }
    var showXAxis: Bool { get }
    var scrollViewHorizontalBounce: Bool { get }
}

public extension VerticalBarChartStyleGuide {
    var barCornerRadius: CGFloat {
        return 8.0
    }
    
    var xTopLabelSpacing: CGFloat {
        return 0.0
    }
    
    var xBottomLabelSpacing: CGFloat {
        return 0.0
    }
    
    var yTopLabelSpacing: CGFloat {
        return 0.0
    }
    
    var yBottomLabelSpacing: CGFloat {
        return 0.0
    }
    
    var showXAxis: Bool {
        return false
    }
    
    var scrollViewHorizontalBounce: Bool {
        return true
    }
}

internal struct VerticalBarChartDefaultStyle: VerticalBarChartStyleGuide {
    var barWidth: CGFloat
    var barSpacing: CGFloat
    var barChartHeight: CGFloat?
    
    init(barWidth: CGFloat = 40.0, barSpacing: CGFloat = 16.0, barChartHeight: CGFloat? = nil) {
        self.barWidth = barWidth
        self.barSpacing = barSpacing
        self.barChartHeight = barChartHeight
    }
}
